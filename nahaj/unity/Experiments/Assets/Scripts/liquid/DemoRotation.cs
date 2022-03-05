using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DemoRotation : MonoBehaviour {

	// Use this for initialization
    private BottleSmash BS;
    public float rotSpeed = 30.0f;
	void Start ()
	{
	    BS = GetComponent<BottleSmash>();
	}
	
	// Update is called once per frame
	void Update () {
		Vector3 a;
		a = BS.GetRandomRotation ().normalized;
		if(a != Vector3.zero)
		if (Vector3.Dot(BS.GetRandomRotation ().normalized, (BS.transform.up + Vector3.up).normalized) < 0.98f) {
			BS.transform.rotation = Quaternion.RotateTowards (BS.transform.rotation, Quaternion.LookRotation (BS.GetRandomRotation (), (BS.transform.up + Vector3.up).normalized), rotSpeed * Time.deltaTime);
		}
	}
}
