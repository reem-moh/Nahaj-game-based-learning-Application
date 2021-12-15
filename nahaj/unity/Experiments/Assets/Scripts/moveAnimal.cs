using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Lean.Touch;

public class moveAnimal : MonoBehaviour
{
    //lean touch script
    private LeanDragTranslate drag;
    private Rigidbody rb;
    private BoxCollider cr;

        //for the instructions button
    [SerializeField] private NextInstruction nextInstruction;
    [SerializeField] private AudioSource audioSource;

    //check image enables
    [SerializeField] private GameObject enableCheck;
    [SerializeField] private Transform target;

    // Start is called before the first frame update
    void Start()
    {
        drag = gameObject.GetComponent<LeanDragTranslate>();
        rb = gameObject.GetComponent<Rigidbody>();
        cr = gameObject.GetComponent<BoxCollider>();
    }

    void OnCollisionEnter(Collision other){
        Debug.Log("\nOnCollisionEnter");
       // if (other.gameObject.CompareTag("Cube"))
       // {
            Debug.Log("Triggered by Cube");
            //change the position of bottle above the volcano
            if(drag.enabled){
                //turn off some property 
                Debug.Log("\n\t\t***** Disable method *****\t\t\n");

                //disable lean touch 
               drag.enabled = false;

              //disable the rigidbody
              rb.isKinematic = true ; 
              rb.detectCollisions = false;

              //disable collider
              cr.enabled = false;

              Debug.Log("\n\t\t***** End of Disable method *****\t\t\n");

              //before move the object
              Debug.Log("before: "+gameObject.GetComponent<Transform>().position);

                
              gameObject.GetComponent<Transform>().position = target.position;

                //after move the object
               // Debug.Log("after: "+gameObject.GetComponent<Transform>().position);
    
            }
      //  }
    }
}
