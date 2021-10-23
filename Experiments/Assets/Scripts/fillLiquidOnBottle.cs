using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Touch;

public class fillLiquidOnBottle : MonoBehaviour
{
    //lean touch script
    private LeanDragTranslate drag;

    private Animator pourLiquid;

    //for the instructions button
    [SerializeField] private NextInstruction nextInstruction;

    void Start ()
    {
        drag = gameObject.GetComponent<LeanDragTranslate>();
        pourLiquid = gameObject.GetComponent<Animator>();
    }

    
   
    void OnCollisionEnter(Collision other){
        Debug.Log("\nOnCollisionEnter");
        if (other.gameObject.CompareTag("Cube"))
        {
            Debug.Log("Triggered by Cube from water bottle");

            Debug.Log("**************");
            //change the position of bottle above the volcano

            if(drag.enabled){
                //turn off lean scribts to not let user move bottle
                disableDrag();

              Debug.Log("before: "+gameObject.GetComponent<Transform>().position);

              // Vector3(-0.074000001,0.379999995,-1.78779999e-06)
             Vector3 p= gameObject.GetComponent<Transform>().position;
             //(-0.05f+p.x),p.y,p.z
             gameObject.GetComponent<Transform>().position = new Vector3(p.x,p.y,p.z);
              Debug.Log("after: "+gameObject.GetComponent<Transform>().position);
             Debug.Log("**************");

              //pour liquid 
                enableAnimation();
            }
            
        }
        
    }

    void disableDrag(){
        Debug.Log("\n\t\t*****Disable lean touch*****\t\t\n");
        drag.enabled = false;
    }

    void enableAnimation(){
        Debug.Log("\n\t\t*****Pour liquid*****\t\t\n");
        pourLiquid.SetTrigger("isCollider");
        //gameObject.GetComponent<ParticleSystem>().Play();
    }

    void distroy(){
        nextInstruction.enableClickable();
        Debug.Log("\n\t\t*****distroy Object*****\t\t\n");
        Object.Destroy(gameObject, 0.02f);
    }
}

