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
    [SerializeField] private AnimalExpInstructions nextInstruction;
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private BoxCollider crStraws;

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
        //if (other.gameObject.CompareTag("Straw"))
        //{
            Debug.Log("Triggered by "+other.gameObject.tag);
            //change the position of animal to the target
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
              //disable collider of straws
              crStraws.enabled = false;
              Debug.Log("\n\t\t***** End of Disable method ***** \t"+other.gameObject.tag+"\n");

              //before move the object
              Debug.Log("before: "+gameObject.GetComponent<Transform>().position);

                
              gameObject.GetComponent<Transform>().position = target.position;
              //gameObject.GetComponent<Transform>().rotation =new Vector3(1.8197155f,39.4758301f,359.724487f);

               //after move the object
              Debug.Log("after: "+gameObject.GetComponent<Transform>().position);
              
              //display next instruction
              nextInstruction.ShowInstruction();
              
              //display check icon
              enableCheck.SetActive(true);

              //update progress bar
              nextInstruction.incrementPB();
    
            }
       // }
    }
}
