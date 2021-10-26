using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PS_Color : ColorBase {

    // Use this for initialization
    public BottleSmash bottleSmash;
    private ParticleSystem ps;
    void Start ()
    {
        ps = GetComponent<ParticleSystem>();
        if (bottleSmash == null)
        {
            bottleSmash = GetComponentInParent<BottleSmash>();
        }
        RegisterWithController();
    }
    protected override void RegisterWithController()
    {
        bottleSmash.RegisterColorBase(this);
    }
    // Update is called once per frame
    public override void Unify()
    {
        UpdateValues();
    }
    public void UpdateValues ()
	{
        //get the main block.
	    ParticleSystem.MainModule mm = ps.main;
        //apply the color;
        mm.startColor = new ParticleSystem.MinMaxGradient(bottleSmash.color);
	    


	}
}
