using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PourLiquid : MonoBehaviour {

	// Use this for initialization
    //how quickly it takes to empty
    public float rateOfFlow = 1.0f;
    //such b....stuff
    public BottleSmash smashScript;
    public LiquidVolumeAnimator liquid;
    public Transform controllingTransform;
    public ParticleSystem pouringParticleSystem;
    //how many particles it takes to empty
    public float volumeOfParticles = 70.0f;
    private Rigidbody corkRB;
	void Start () {
        if (smashScript != null)
        {
            if (smashScript.Cork != null)
            {
                corkRB = smashScript.Cork.GetComponent<Rigidbody>();
            }
        }
	}
	
	// Update is called once per frame
	void Update () {
        if(corkRB != null)
        {
            if (corkRB.isKinematic)
                return;
            else if (!corkRB.gameObject.activeInHierarchy)
                return;
        }

        float d = Vector3.Dot(controllingTransform.up, (liquid.finalPoint  - liquid.finalAnchor).normalized);
        float d2 = (d + 1.0f) / 2;
        float particleVal = 0.0f;
        if(d2 < liquid.level)
        {
            particleVal = (liquid.level - d2) * rateOfFlow;
            liquid.level = Mathf.Lerp(liquid.level, d2, Time.deltaTime * rateOfFlow);
        }
        if(d <= 0.0f)
        {
            if(liquid.level > float.Epsilon)
                particleVal = liquid.level;
            liquid.level = Mathf.Lerp(liquid.level, 0, Time.deltaTime * rateOfFlow);
        }
        if(pouringParticleSystem != null)
        {
            ParticleSystem.MinMaxCurve emi = pouringParticleSystem.emission.rateOverTime;
            emi.constant = volumeOfParticles * particleVal;
            ParticleSystem.EmissionModule emod = pouringParticleSystem.emission;
            emod.rateOverTime = emi;
            //pouringParticleSystem.emission = emod;
            if(particleVal > 0)
            {
                if(!pouringParticleSystem.isEmitting)
                {
                    pouringParticleSystem.Play();
                }
            }
            else
            {
                pouringParticleSystem.Stop(false, ParticleSystemStopBehavior.StopEmitting);
            }
        }
		
	}
}
