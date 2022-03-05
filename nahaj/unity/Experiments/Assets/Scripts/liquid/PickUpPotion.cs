using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickUpPotion : MonoBehaviour {

	// Use this for initialization
    private GameObject Obj;
    private Rigidbody rObj;
    private float dist;
	float d;
	public float offsetValue = 1;
	private Vector2 beginDist;
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

        Ray r = Camera.main.ScreenPointToRay(Input.mousePosition);
        if (Input.GetMouseButtonDown(0) && Obj == null)
        {


            RaycastHit hitInfo = new RaycastHit();
            
            bool hit = Physics.Raycast(r, out hitInfo);
            if (hit)
            {
                //Debug.Log("Hit " + hitInfo.transform.gameObject.name);
                if (hitInfo.transform.gameObject.tag == "Potion")
                {
                    dist = hitInfo.distance;
					beginDist = Input.mousePosition;
                    Obj = hitInfo.transform.gameObject;
                    rObj = Obj.GetComponent<Rigidbody>();
                }
                else
                {

                }
            }
            else
            {

            }
        }
        else if(Obj !=null && Input.GetMouseButtonDown(0))
        {
            rObj.isKinematic = false;
            rObj.useGravity = true;
            rObj = null;
            Obj = null;
        }
        if(Obj != null)
        {
			Vector2 d1 = (beginDist - (Vector2)Input.mousePosition);
			d1 = new Vector2 (d1.x / (beginDist.x / 2), d1.y / (beginDist.y / 2));
			d = d1.magnitude;
			Obj.transform.position = r.origin + r.direction.normalized * dist + (r.direction.normalized * (d) * -1 * offsetValue);  

        }

            

		
	}
}
