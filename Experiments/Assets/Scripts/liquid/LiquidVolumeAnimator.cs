using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class LiquidVolumeAnimator : MonoBehaviour {

	// Use this for initialization
    //just incase we have multiple materials;
    [HideInInspector]
    [SerializeField]
    public Material[] mats;
    //the level of the liquid on a hyperplane.
    [Range(0,1)]
    [SerializeField]
    public float level = 0.5f;
    private float finalLevel;
    
    //the current bound given a direction
    public Vector2 minMaxBounds;
    //the mesh to 
    [HideInInspector]
    [SerializeField]
    private MeshFilter mf;
    [HideInInspector]
    [SerializeField]
    private MeshRenderer mr;
    [HideInInspector]
    [SerializeField]
    private Mesh m;
    //in order to see how its working, physics is kind of hacked in
    public bool DebugAnchor = false;
    //debugsize is how large the handles are
    public float debugSize = 1.0f;
    //how much mass it has? kind of?
    public float _anchorLength = 0.5f;
    //how much the rotation and movement applies to the anchor
    [Range(0,1)]
    public float dampening;
    //it always wants to be rotated to down
    [HideInInspector]
    [SerializeField]
    private Vector3 anchor;
    //velocity of the direction of 'gravity'
    [HideInInspector]
    [SerializeField]
    private Vector3 anchorVelocity;
    //direction of velocity after clamp. ALSO used to see if the position has changed and use that as a velocity reference;
    [HideInInspector]
    [SerializeField]
    private Vector3 transformedPoint, prevTransformedPoint;
    public bool calculateTextureProjection = true;
    public float TextureSize = 1.0f;
    public float TextureSizeScalar = 1;
    public AnimationCurve texCurveSize = AnimationCurve.Linear(0, 1, 1, 1);
    //for rotation of the texture;
    Quaternion previous;
    float totalRotation = 0.0f;
    [HideInInspector]
    [SerializeField]
    private Vector3 TopLeft, TopRight, BottomLeft, BottomRight;

    public Transform ExposedLiquidT;
    public Vector3 GravityDirection = Vector3.down;
    public bool normalizeGravityDirection = true;
    //vert cache
    [HideInInspector]
    [SerializeField]
    Vector3[] verts;
	int shader_Key_localHeight;
	int shader_Key_anchor;
	int shader_Key_point;
	int shader_Key_level;
    float prvLevel = -1;
    Quaternion prevQ = Quaternion.identity;
    //for debugging purposes
    //for caching
    [HideInInspector]
    [SerializeField]
    Vector3 cPos = Vector3.zero;

	//output values:
	public Vector3 finalAnchor, finalPoint;
    [HideInInspector]
    [SerializeField]
    string[] shaderNames;
    void OnDrawGizmosSelected()
    {
        float anchorLength = _anchorLength * Mathf.Max(transform.lossyScale.x, transform.lossyScale.y, transform.lossyScale.z);
        if(DebugAnchor)
        {
            cPos = transform.position;
            //Vector3 prevTransformedPointD = transform.TransformDirection(Vector3.down);
            Vector3 anchorD = cPos - transform.TransformDirection(Vector3.up) * anchorLength;
            if (anchor == Vector3.zero)
                anchor = anchorD;
            //makes sure something is available (even while not playing).

            CalculateSquare(anchor);
            //the location of the anchor (static)
            Gizmos.DrawSphere(anchorD, 0.25f * transform.lossyScale.magnitude * 0.1f * debugSize);
            //line between the anchor and the surface
            Gizmos.DrawLine(cPos, anchorD);
            Gizmos.color = Color.blue;
            //the ocation of the anchor (physics)
            Gizmos.DrawSphere(anchor, 0.25f * transform.lossyScale.magnitude * 0.1f * debugSize);
           
            Gizmos.color = Color.red;
            Gizmos.DrawSphere(cPos - (anchorD - cPos).normalized * finalLevel, 0.1f * transform.lossyScale.magnitude * 0.01f * debugSize);
            //All four corners of the texture
            Gizmos.color = Color.yellow;
            Gizmos.DrawSphere(TopLeft, 0.25f * transform.lossyScale.magnitude * 0.01f * debugSize);
            Gizmos.DrawSphere(TopRight, 0.25f * transform.lossyScale.magnitude * 0.01f * debugSize);
            Gizmos.DrawSphere(BottomLeft, 0.25f * transform.lossyScale.magnitude * 0.01f * debugSize);
            Gizmos.DrawSphere(BottomRight, 0.25f * transform.lossyScale.magnitude * 0.01f * debugSize);
            Gizmos.color = Color.white;
            CalculateSquare(anchor);
        }
    }

    void CalculateSquare(Vector3 anch)
    {
        if (!calculateTextureProjection)
        {
            return;
        }
        Vector3 pos1 = cPos - (anch - cPos).normalized * finalLevel;
        Vector3 nrm = (cPos - (anch - cPos).normalized * finalLevel - anch).normalized;
        Vector3 beginningRight = Quaternion.Euler(0, totalRotation, 0) * Vector3.right;
        Vector3 f1 = Vector3.Cross(beginningRight, nrm.normalized).normalized;
        Vector3 r1 = Vector3.Cross(f1, nrm).normalized;
        f1 = Vector3.Cross(r1, nrm).normalized;
        float tSize = TextureSize * texCurveSize.Evaluate(Mathf.Clamp01(level)) * transform.lossyScale.magnitude * 0.001f;
        
        TopLeft = r1 * tSize + f1 * tSize + pos1;
        TopRight = r1 * tSize * -1 + f1 * tSize + pos1;
        BottomLeft = r1 * tSize + f1 * tSize * -1 + pos1;
        BottomRight = r1 * tSize * -1 - f1 * tSize + pos1;
    }

	void Start ()
	{
        cPos = transform.position;
		shader_Key_localHeight = Shader.PropertyToID ("_localHeight");
		shader_Key_anchor = Shader.PropertyToID ("_anchor");
		shader_Key_point = Shader.PropertyToID ("_point");
		shader_Key_level = Shader.PropertyToID ("_level");
        //delta
		prevTransformedPoint = transformedPoint = transform.TransformDirection((normalizeGravityDirection) ? GravityDirection.normalized : GravityDirection);
        //anchor = cPos - transform.TransformDirection(Vector3.up) * anchorLength;
        anchor -= ((normalizeGravityDirection) ? GravityDirection.normalized : GravityDirection) * -1 * Time.deltaTime * (1.0f - dampening);
        anchor.Normalize();
	    mr = GetComponent<MeshRenderer>();
	    mats = mr.materials;
        shaderNames = new string[mats.Length];

        for (int i = 0; i < mats.Length; ++i)
	    {
	        mats[i] = Instantiate(mats[i]);
            shaderNames[i] = mats[i].shader.name;

        }
	    mf = GetComponent<MeshFilter>();
	    m = mf.sharedMesh;
		verts = new Vector3[m.vertices.Length];
	    verts = m.vertices;
	    minMaxBounds.x = minMaxBounds.y = verts[0].y;
        
	    for (int i = 0; i < verts.Length; ++i)
	    {
            Vector3 wPos = transform.TransformDirection(verts[i]);
            if (wPos.y > minMaxBounds.y)
	        {
	            minMaxBounds.y = wPos.y;
	        }
	        if (wPos.y < minMaxBounds.x)
	        {
	            minMaxBounds.x = wPos.y;
	        }
	    }
	    minMaxBounds.x -= cPos.y;
	    minMaxBounds.y -= cPos.y;
	    for (int i = 0; i < mats.Length; ++i)
	    {
			mats[i].SetFloat(shader_Key_localHeight, Mathf.Lerp(minMaxBounds.x,minMaxBounds.y,level));
	    }

	    mr.materials = mats;

	}
	public void AddForce(Vector3 force)
    {
        anchorVelocity += force;
    }
	// Update is called once per frame
	void FixedUpdate ()
	{
        cPos = transform.position;
        float nLength = _anchorLength * Mathf.Max(transform.lossyScale.x, transform.lossyScale.y, transform.lossyScale.z);
        //prevTransformedPoint = transform.TransformDirection(Vector3.down);
        //anchor = transform.position - transform.TransformDirection(Vector3.up) * nLength;
        transformedPoint = transform.TransformDirection((normalizeGravityDirection) ? GravityDirection.normalized : GravityDirection);
        
        ////Now we need to move the anchor down by gravity;
        //anchorVelocity += Vector3.down * Time.deltaTime * 0.1f;
        anchor += anchorVelocity * (1.0f - dampening);
        Vector3 prevPos = anchor;
        anchor -= ((normalizeGravityDirection) ? GravityDirection.normalized : GravityDirection) * -1 * Time.deltaTime * (1.0f - dampening);
        
        //clamp it
        float d = Vector3.Distance(anchor, cPos);
        //float difference = (nLength - d) / d;
        //float d2 = d / nLength;

        if (d > nLength)
        {
            anchor = cPos + (anchor - cPos).normalized * nLength;
            //connections[i].position = connections[i].position + (cPos - connections[i].position).normalized * difference * 0.5f;
        }
		Vector3 addition = (anchor - prevPos) + (transformedPoint - prevTransformedPoint) * -1 * (1.0f / nLength) * Time.deltaTime;
		//if there is no change dont bother updating.
		if (addition == Vector3.zero)
        {
            if (prvLevel == level && prevQ == transform.rotation)
			    return;
        }
        anchorVelocity += addition;
        //find the difference and add it to the velocity;

        //Vector3 lastPos = anchor;
        //anchor += anchorVelocity * Time.deltaTime;
        //anchor = (anchor - cPos).normalized * anchorLength;
        //add the direction as velocity;
        //anchorVelocity += (b - lastPos);
        Matrix4x4 localToWorld = transform.localToWorldMatrix;
        minMaxBounds.x = minMaxBounds.y = (transform.TransformPoint(verts[0])).y;
        for (int i = 0; i < verts.Length; ++i)
        {
            Vector3 wPos = localToWorld.MultiplyPoint(verts[i]);
            //Vector3 wPos = transform.TransformPoint(verts[i]);
            if (wPos.y > minMaxBounds.y)
            {
                minMaxBounds.y = wPos.y;
            }
            if (wPos.y < minMaxBounds.x)
            {
                minMaxBounds.x = wPos.y;
            }
        }
        minMaxBounds.y -= cPos.y;
        minMaxBounds.x -= cPos.y;
        //minMaxBounds.x += cPos.y;
        //minMaxBounds.y += cPos.y;
        finalLevel = Mathf.Lerp(minMaxBounds.x, minMaxBounds.y, level);
        if(level <= Single.Epsilon * 10)
        {
            //dont render (turn off renderer)
            anchor = Vector3.down * nLength + cPos;
        }
		finalPoint = (cPos - (anchor - cPos).normalized * finalLevel);
			
        for (int i = 0; i < mats.Length; ++i)
        {
			mats[i].SetFloat(shader_Key_localHeight, Mathf.Lerp(minMaxBounds.x - Single.Epsilon * 10, minMaxBounds.y + Single.Epsilon * 10, level));
			mats[i].SetVector(shader_Key_anchor, transform.InverseTransformPoint(anchor));
			mats[i].SetVector(shader_Key_point, transform.InverseTransformPoint(cPos - (anchor - cPos).normalized * finalLevel));
			mats[i].SetFloat(shader_Key_level, level - Single.Epsilon);//to make sure its not rendered accidentally by rotations
        }


        //lets update the size of the plane (for texture projection);
	   // Vector3 anchorD = cPos - transform.TransformDirection(Vector3.up) * anchorLength;
		finalAnchor = anchor;
        CalculateSquare(anchor);
        //lets find the delta y rotation; (global);
        //Quaternion rot = Quaternion.RotateTowards(previous, transform.rotation, 360);
        //make two quaternions static on the xz plane (only rotation about the y)
        Quaternion q1 = Quaternion.LookRotation(previous * Vector3.right, Vector3.up);
        //to find the obtuse angle
        Vector3 vqf = q1 * Vector3.right;
        //returns the acute angle, very cute indeed.
        Quaternion q2 = Quaternion.LookRotation(transform.rotation * Vector3.right, Vector3.up);
        float angle = Quaternion.Angle(q1, q2) * ((Vector3.Dot(vqf,q2 * Vector3.forward) < 0) ? -1 : 1);
        float ydelta = angle;
        //to correct weird rotations (from cross product potentially). (approximation errors)
        if(Mathf.Abs(ydelta) > 0.05f)
        totalRotation += ydelta;
        if(totalRotation > 360)
        {
            totalRotation -= 360;
        }
        else if(totalRotation < 0)
        {
            totalRotation += 360;
        }

        if (ExposedLiquidT != null)
        {
            ExposedLiquidT.position = cPos - (anchor - cPos).normalized * finalLevel;
            ExposedLiquidT.localScale = Vector3.one *texCurveSize.Evaluate(Mathf.Clamp01(level)) * transform.lossyScale.magnitude * 0.001f * TextureSize * TextureSizeScalar;
            ExposedLiquidT.up = (finalPoint - finalAnchor).normalized;
            
        }


        prevTransformedPoint = transformedPoint;
        previous = transform.rotation;
        //finally, lets set the plane.

        Vector4 sTopLeft = transform.InverseTransformPoint(TopLeft);
        Vector4 sTopRight = transform.InverseTransformPoint((TopRight));
        Vector4 sBotLeft = transform.InverseTransformPoint((BottomLeft));
        Vector4 sBotRight = transform.InverseTransformPoint((BottomRight));
        Vector4 sCenter = transform.InverseTransformPoint(cPos - (anchor - cPos).normalized * finalLevel);
        for (int i = 0; i < mats.Length; ++i)
        {
			if (!shaderNames[i].Contains ("_Texture"))
				continue;
			mats[i].SetVector("_TL", sTopLeft);
			mats[i].SetVector("_TR", sTopRight);
			mats[i].SetVector("_BL", sBotLeft);
			mats[i].SetVector("_BR", sBotRight);
			mats[i].SetVector("_CENTER", sCenter);
        }
        prvLevel = level;
        prevQ = transform.rotation;

    }
}
