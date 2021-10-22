using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParticleColor : ColorBase {

	// Use this for initialization
    public BottleSmash bottleSmash;
    private ParticleSystemRenderer ps;
    public ColorID colorType;

    public enum ColorID
    {
        _TintColor,
        _Color
    }

	void Start ()
	{
	    ps = GetComponent<ParticleSystemRenderer>();
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
    public override void Unify()
    {
        //apply the material color
        switch (colorType)
        {
            case ColorID._TintColor:
            {
                ps.material.SetColor("_TintColor", bottleSmash.color);
                break;
            }
            case ColorID._Color:
            {
                ps.material.SetColor("_Color", bottleSmash.color);
                break;
            }
        }

    }
}
