using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Touch;

public class fillLiquidOnBottle : MonoBehaviour
{
    //lean touch script
    private LeanDragTranslate drag;

    private Animator pourLiquid;

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

            //change the position of bottle above the volcano
            gameObject.GetComponent<Transform>().position = new Vector3(-0.403f, 0.38f, 0f);

            
            if(drag.enabled){
             //turn off lean scribts to not let user move bottle
                disableDrag();
              //pour liquid 
                enableAnimation();
            }
            
        }
        
    }

    void disableDrag(){
        Debug.Log("\n\n\n*****Disable lean touch*****\n\n\n");
        drag.enabled = false;
    }

    void enableAnimation(){
        Debug.Log("\n\n\n*****Pour liquid*****\n\n\n");
        pourLiquid.SetTrigger("isCollider");
    }

    void distroy(){
        Object.Destroy(gameObject, 2.0f);
    }
}
