using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class MeshLiquidEmission : MonoBehaviour {

    // Use this for initialization
    [System.Serializable]
    private class BVertex
    {
        public Vector3 p;
        public Vector3 n;
        public bool b;
    }
    [HideInInspector]
    [SerializeField]
    private MeshFilter r;
    
	public LiquidVolumeAnimator LVA;
    [HideInInspector]
    [SerializeField]
    int[] calculatedTriangles;
    [HideInInspector]
    [SerializeField]
    BVertex[] calculatedVerts;
    public ParticleSystem system;
    float particlesToEmit = 0;
    public float emissionSpeed = 0.0f;
	private Mesh m;
    [HideInInspector]
    [SerializeField]
    int[] tris;
    [HideInInspector]
    [SerializeField]
    Vector3[] verts, norms;
    public bool debug = false;
    public float debugScale = 1.0f;
    public bool CullNullNormals = false;
    public Rigidbody Cork;
    public float volumeOfParticles = 70.0f;
    public bool emitting = true;
    public BottleSmash bottleSmash;
    public float angleSpeedScalar = 1.0f;
    int CVOB = 0;
    void Start () {
        r = GetComponent<MeshFilter>();
		m = r.mesh;
        calculatedVerts = new BVertex[m.vertexCount * 6];

        for(int i = 0; i < calculatedVerts.Length; ++i)
        {
            calculatedVerts[i] = new BVertex();
        }
        verts = m.vertices;
        tris = m.triangles;
        norms = m.normals;
    }
    bool LinePlaneIntersection(Vector3 p0, Vector3 p1, Vector3 planePoint, Vector3 planeNormal, out Vector3 coordinate)
    {
        Vector3 line = p1 - p0;
        coordinate = Vector3.zero;
        float d = Vector3.Dot(planeNormal.normalized, line);
        if(Mathf.Abs(d) > float.Epsilon)
        {
            Vector3 w = p0 - planePoint;
            float fac = (Vector3.Dot(planeNormal.normalized, w) * -1) / d;
            line = line * fac;
            coordinate = p0 + line;
            return true;
        }
        else
        {
            
            return false;
        }
    }
	void OnDrawGizmos()
	{
        if (!debug)
            return;
        if(calculatedVerts != null)
        {
            for(int i =0; i < calculatedVerts.Length; ++i)
            {
                if (!calculatedVerts[i].b)
                    break;
                Gizmos.DrawSphere(transform.TransformPoint(calculatedVerts[i].p), 0.01f * transform.lossyScale.magnitude * debugScale);
            }
        }


    }
	// Update is called once per frame
    void SetDual(int under1, int under2, int above, ref Vector3 dir, ref Vector3 lpos, ref int currentVOB, ref Vector3 tmpV)
    {
        
        calculatedVerts[currentVOB].p = verts[under1];
        calculatedVerts[currentVOB].n = norms[under1];
        calculatedVerts[currentVOB].b = true;

        LinePlaneIntersection(verts[under1], verts[above], lpos, (dir * -1), out tmpV);
        calculatedVerts[currentVOB + 1].p = tmpV;
        calculatedVerts[currentVOB + 1].n = Vector3.Lerp(norms[under1], norms[above], (tmpV - verts[under1]).magnitude / (verts[under1] - verts[above]).magnitude);
        calculatedVerts[currentVOB + 1].b = true;

        calculatedVerts[currentVOB + 2].p = verts[under2];
        calculatedVerts[currentVOB + 2].n = norms[under2];
        calculatedVerts[currentVOB + 2].b = true;

        calculatedVerts[currentVOB + 3].p = verts[under2];
        calculatedVerts[currentVOB + 3].n = norms[under2];
        calculatedVerts[currentVOB + 3].b = true;

        calculatedVerts[currentVOB + 4].p = tmpV;
        calculatedVerts[currentVOB + 4].n = calculatedVerts[currentVOB + 1].n;
        calculatedVerts[currentVOB + 4].b = true;

        LinePlaneIntersection(verts[under2], verts[above], lpos, (dir * -1), out tmpV);
        calculatedVerts[currentVOB + 5].p = tmpV;
        calculatedVerts[currentVOB + 5].n = Vector3.Lerp(norms[under2], norms[above], (tmpV - verts[under2]).magnitude / (verts[under2] - verts[above]).magnitude);
        calculatedVerts[currentVOB + 5].b = true;
    }
    void SetDualInverted(int under1, int above1, int above2, ref Vector3 dir, ref Vector3 lpos, ref int currentVOB, ref Vector3 tmpV)
    {

        calculatedVerts[currentVOB].p = verts[under1];
        calculatedVerts[currentVOB].n = norms[under1];
        calculatedVerts[currentVOB].b = true;

        LinePlaneIntersection(verts[under1], verts[above1], lpos, (dir * -1), out tmpV);
        calculatedVerts[currentVOB + 1].p = tmpV;
        calculatedVerts[currentVOB + 1].n = Vector3.Lerp(norms[under1], norms[above1], (tmpV - verts[under1]).magnitude / (verts[under1] - verts[above1]).magnitude);
        calculatedVerts[currentVOB + 1].b = true;

        LinePlaneIntersection(verts[under1], verts[above2], lpos, (dir * -1), out tmpV);
        calculatedVerts[currentVOB + 2].p = tmpV;
        calculatedVerts[currentVOB + 2].n = Vector3.Lerp(norms[under1], norms[above2], (tmpV - verts[under1]).magnitude / (verts[under1] - verts[above2]).magnitude);
        calculatedVerts[currentVOB + 2].b = true;

    }
    void CalculateTrianglesToEmitFrom(int[] tris, Vector3[] verts)
    {
        Vector3 dir = (LVA.finalAnchor - LVA.finalPoint).normalized;
        Vector3 lpos = transform.InverseTransformPoint(LVA.finalPoint);
        dir = transform.InverseTransformDirection(dir).normalized;
        int currentVOB = 0;
        Vector3 tmpV = Vector3.zero;
        //for every triangle, check if ANY vertex is below the level.   
        for (int i = 2; i < tris.Length; i+=3)
        {
            int v1i = tris[i - 2], v2i = tris[i - 1], v3i = tris[i];
            Vector3 v1 = verts[v1i], v2 = verts[v2i], v3 = verts[v3i];
            
            Vector3 v1d = v1 - lpos;
            bool v1b = Vector3.Dot(dir, v1d) >= 0;
            Vector3 v2d = v2 - lpos;
            bool v2b = Vector3.Dot(dir, v2d) >= 0;
            Vector3 v3d = v3 - lpos;
            bool v3b = Vector3.Dot(dir, v3d) >= 0;
            //all are under
            if(v3b && v2b && v1b)
            {
                //add ALL vertices to buffer
                calculatedVerts[currentVOB].p = v1;
                calculatedVerts[currentVOB].n = norms[v1i];
                calculatedVerts[currentVOB].b = true;
                calculatedVerts[currentVOB+1].p = v2;
                calculatedVerts[currentVOB+1].n = norms[v2i];
                calculatedVerts[currentVOB+1].b = true;
                calculatedVerts[currentVOB+2].p = v3;
                calculatedVerts[currentVOB+2].n = norms[v2i];
                calculatedVerts[currentVOB+2].b = true;
                currentVOB += 3;
                continue;

            }
            else if(!(v3b || v2b || v1b))
            {
                //none are in, do nothing
                continue;
            }
            else
            {
                //one or TWO of them out of 3 are under;
                bool found = false;
                if(v1b && v2b)
                {

                    //subdivide face with projected vertices
                    SetDual(v1i, v2i, v3i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 6;
                    found = true;
                }
                if (v1b && v3b)
                {
                    SetDual(v1i, v3i, v2i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 6;
                    found = true;
                }
                if (v2b && v3b)
                {
                    SetDual(v3i, v2i, v1i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 6;
                    found = true;
                }
                if(found)
                {
                    continue;
                }
                if(v1b)
                {
                    SetDualInverted(v1i, v2i, v3i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 3;
                    
                    continue;
                }
                if (v2b)
                {
                    SetDualInverted(v2i, v1i, v3i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 3;

                    continue;
                }
                if (v3b)
                {
                    SetDualInverted(v3i, v2i, v1i, ref dir, ref lpos, ref currentVOB, ref tmpV);
                    currentVOB += 3;

                    continue;
                }
                continue;
            }

        }
        if(currentVOB < calculatedVerts.Length)
        {
            calculatedVerts[currentVOB].b = false;
        }
        CVOB = currentVOB;

    }
    float GetPS_StartSpeed()
    {
        switch (system.main.startSpeed.mode)
        {
            case ParticleSystemCurveMode.TwoConstants:
                return UnityEngine.Random.Range(system.main.startSpeed.constantMin, system.main.startSpeed.constantMax);
            case ParticleSystemCurveMode.Constant:
                return system.main.startSpeed.constant;
            case ParticleSystemCurveMode.Curve:
                return system.main.startSpeed.Evaluate(UnityEngine.Random.value);
            case ParticleSystemCurveMode.TwoCurves:
                return system.main.startSpeed.Evaluate(UnityEngine.Random.value);

            default:
                return 0.0f;
        }
    }
    bool EmitFromSubmesh()
    {
        //randomly select ONE triangle;
        // div by 3

        int index = UnityEngine.Random.Range(0,(CVOB / 3)-1);
        //multiply out to corresponding id;
        index *= 3;
        //find the position to emit from;
        //pick vert1, lerp to v2 randomly, then v3 randomly.
        float r1 = UnityEngine.Random.value;
        float r2 = UnityEngine.Random.value;
        Vector3 pos = Vector3.Lerp(calculatedVerts[index].p, calculatedVerts[index + 1].p, r1);
        Vector3 nrm = Vector3.Lerp(calculatedVerts[index].n, calculatedVerts[index + 1].n, r1).normalized;
        pos = Vector3.Lerp(pos, calculatedVerts[index + 2].p, r2);
        nrm = Vector3.Lerp(nrm, calculatedVerts[index + 2].n, r2).normalized;
        //ParticleSystem.Particle p = new ParticleSystem.Particle();
        //p.position = pos;
        //p.angularVelocity3D = 
        ParticleSystem.EmitParams param = new ParticleSystem.EmitParams();
        float pouringAngle = 1;

        if (bottleSmash != null)
        {
            Vector3 wNrm = transform.TransformDirection(nrm).normalized;
            pouringAngle = ((1.0f + Vector3.Dot((LVA.finalAnchor - LVA.finalPoint).normalized, wNrm))/2.0f);
            param.velocity = wNrm * GetPS_StartSpeed() * pouringAngle * angleSpeedScalar;
        }
        else
        {
            param.velocity = transform.TransformDirection(nrm).normalized * GetPS_StartSpeed();
        }
        
        param.position = transform.TransformPoint(pos);
        if (param.velocity == Vector3.zero && CullNullNormals)
            return false;

        particlesToEmit -= 1;

        //adjust level
        if (Cork != null)
        {
            if (Cork.isKinematic && volumeOfParticles > 0)
            {
                //
                LVA.level = Mathf.Clamp01((volumeOfParticles * LVA.level - 1) / volumeOfParticles);
                
            }
        }
        else if(volumeOfParticles > 0)
        {
            LVA.level = Mathf.Clamp01((volumeOfParticles * LVA.level - 1) / volumeOfParticles);
        }

        system.Emit(param, 1);
        return true;
    }
	void Update () {

        if (!emitting || Cork != null)
            return;
        if (LVA.level <= 0)
            return;
        CalculateTrianglesToEmitFrom(tris, verts);
        //triangles are in order
        particlesToEmit += emissionSpeed * Time.deltaTime;
        if(calculatedVerts.Length == 0)
        {
            particlesToEmit = 0;
        }
        else
        {
            if(calculatedVerts[0].b == false)
                particlesToEmit = 0;
        }
        int maxFailInASeq = 10;
        int seq = maxFailInASeq;
        while(particlesToEmit > 0 && (GetPS_StartSpeed() > 0 || !CullNullNormals))
        {
            if (EmitFromSubmesh())
            {
                seq = maxFailInASeq;
            }
            else
            {
                seq -= 1;
            }
            if (seq <= 0)
            {
                break;
            }

            
        }


    }
}
