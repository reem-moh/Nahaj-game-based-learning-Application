using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LiquidAbsorption : MonoBehaviour {

    //public int collisionCount = 0;
    public Color currentColor;
    public BottleSmash smashScript;
    public float particleValue = 0.02f;
    public LiquidVolumeAnimator LVA;
	// Use this for initialization
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
        if (available)
        {
            currentColor = smashScript.color;
            if (LVA.level < 1.0f - particleValue)
            {

                //essentially, take the ratio of the bottle that has liquid (0 to 1), then see how much the level will change, then interpolate the color based on the dif.
                Color impactColor = other.GetComponentInParent<BottleSmash>().color;

                if (LVA.level <= float.Epsilon * 10)
                {
                    currentColor = impactColor;
                }
                else
                {
                    currentColor = Color.Lerp(currentColor, impactColor, particleValue / LVA.level);
                }
                //collisionCount += 1;
                LVA.level += particleValue;
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
