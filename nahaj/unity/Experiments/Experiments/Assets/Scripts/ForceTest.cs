using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForceTest : MonoBehaviour {

	// Use this for initialization
    public bool AddForce = false;
    public Vector3 force;
    private LiquidVolumeAnimator lva;
	void Start () {
        lva = GetComponent<LiquidVolumeAnimator>();
	}
	
	// Update is called once per frame
	void Update () {
        if(AddForce)
        {
            lva.AddForce(force);
            AddForce = false;
        }
	}
}
