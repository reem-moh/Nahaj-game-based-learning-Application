using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Touch;

public class fillLiquidOnBottle : MonoBehaviour
{
    //lean touch script
    private LeanDragTranslate drag;
    private Animator pourLiquid;
    private Rigidbody rb;
    private BoxCollider cr;
    private bool doneCollsion;
    private Vector3 p;

    //for the instructions button
    [SerializeField] private NextInstruction nextInstruction;
    [SerializeField] private AudioSource audioSource;
    void Start ()
    {
        drag = gameObject.GetComponent<LeanDragTranslate>();
        rb = gameObject.GetComponent<Rigidbody>();
        cr = gameObject.GetComponent<BoxCollider>();
        pourLiquid = gameObject.GetComponent<Animator>();
        doneCollsion = false;
    }

    void update(){
        //to let the object not move
        if(doneCollsion){
            gameObject.GetComponent<Transform>().position = new Vector3(p.x,p.y,p.z);
        }
    }
    
   
    void OnCollisionEnter(Collision other){
        Debug.Log("\nOnCollisionEnter");
        if (other.gameObject.CompareTag("Cube"))
        {
            Debug.Log("Triggered by Cube");
            //change the position of bottle above the volcano
            if(drag.enabled){
                //turn off some property 
                disable();

                //before move the object
                Debug.Log("before: "+gameObject.GetComponent<Transform>().position);
                // Vector3(-0.074000001,0.379999995,-1.78779999e-06)
                //Vector3(-0.125400007,0.344900012,-0.0105999997)
                p = gameObject.GetComponent<Transform>().position;
                p = new Vector3(p.x + 0.0366f,p.y + 0.07f,p.z + -0.0255599f);
                gameObject.GetComponent<Transform>().position = p;
                Debug.Log("after: "+gameObject.GetComponent<Transform>().position);
                //pour liquid 
                enableAnimation();
            }

            doneCollsion = true; 
        }
    }

    void disable(){

        Debug.Log("\n\t\t***** Disable method *****\t\t\n");

        //disable lean touch 
        drag.enabled = false;

        //disable the rigidbody
        rb.isKinematic = true ; 
        rb.detectCollisions = false;

        //disable collider
        cr.enabled = false;

        Debug.Log("\n\t\t***** End of Disable method *****\t\t\n");
    }

    void enableAnimation(){
        Debug.Log("\n\t\t*****Pour liquid*****\t\t\n");
        pourLiquid.SetTrigger("isCollider");
    }

    void distroy(){
        nextInstruction.enableClickable();
        Debug.Log("\n\t\t*****distroy Object*****\t\t\n");
        Object.Destroy(gameObject, 0.02f);
    }

    void enableSound(){
        //audioSource.Play();
        Debug.Log("\n\t\t*****PouringSoundt*****\t\t\n");
        
    }
}

