using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LiquidAbsorptionV2 : MonoBehaviour {

    //public int collisionCount = 0;
    public Color currentColor;
    public BottleSmash smashScript;
    public MeshLiquidEmission LiquidEmission;
    public LiquidVolumeAnimator LVA;
    // Use this for initialization
    float particleValue = 1;

    void Start () {
        if(LVA == null)
        LVA = GetComponent<LiquidVolumeAnimator>();
	}
    void OnParticleCollision(GameObject other)
    {
        //check if it is the same factory.
        if (other.transform.parent == transform.parent)
            return;
        bool available = false;
        if (smashScript.Cork == null)
        {
            available = true;
        }
        else
        {
            //if the cork is not on!
            if (!smashScript.Cork.activeSelf)
            {

                available = true;
            }
                //or it is disabled (through kinamism)? is that even a word?
            else if (!smashScript.Cork.GetComponent<Rigidbody>().isKinematic)
            {
                available = true;
            }
        }
        float finalParticleValue = particleValue * (1.0f / LiquidEmission.volumeOfParticles);
        if (available)
        {
            currentColor = smashScript.color;
            if (LVA.level < 1.0f - finalParticleValue)
            {

                //essentially, take the ratio of the bottle that has liquid (0 to 1), then see how much the level will change, then interpolate the color based on the dif.
                Color impactColor = other.GetComponentInParent<BottleSmash>().color;//cant be cached

                if (LVA.level <= float.Epsilon * 10)
                {
                    currentColor = impactColor;
                }
                else
                {
                    currentColor = Color.Lerp(currentColor, impactColor, finalParticleValue / LVA.level);
                }
                //collisionCount += 1;
                LVA.level += finalParticleValue;
                smashScript.color = currentColor;
                
            }
        }
    }
	// Update is called once per frame
	void Update ()
	{
	    currentColor = smashScript.color;

	}
}
