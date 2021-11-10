using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResetColors : MonoBehaviour {

	// Use this for initialization
    public LiquidVolumeAnimator LVA;
    public float timeout = 5;
    private float tReset;
    public BottleSmash BS;
	public Color Color1,Color2;
	void Start ()
	{
	    tReset = timeout;

	}
	
	// Update is called once per frame
	void Update ()
	{
	    timeout -= Time.deltaTime;
	    if (timeout <= 0.0f)
	    {
	        if(BS.color == Color1)
                BS.color = Color2;
	        else
	        {
	            BS.color = Color1;
	        }
	        LVA.level = 1;
	        timeout = tReset;
	    }
	}
}
