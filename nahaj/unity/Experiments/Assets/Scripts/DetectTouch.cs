using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectTouch : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //tag
    [SerializeField] private string tag;

    // Update is called once per frame
    void Update()
    {
        Debug.Log("-----------------inside update turtule----------------firstTime:"+firstTime+"nextInstruction.instructionIsEnabled4:"+nextInstruction.instructionIsEnabled4+"");
        if(firstTime && nextInstruction.instructionIsEnabled4){
            Debug.Log("-----------------inside if statment of update turtule----------------");
            if(Input.GetMouseButtonDown(0))
             {
                 Debug.Log("-----------------inside if statment of update turtule and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                Debug.Log("\n\n\nhit.transform.name: Plane?? =>"+hit.transform.gameObject+"\n\n\n");
                     if(hit.transform.gameObject.CompareTag(tag)){
                         Debug.Log("hi");
                         firstTime = false;
                         //display next instruction
                         nextInstruction.ShowInstruction();
              
                         //display check icon
                         enableCheck.SetActive(true);

                         //update progress bar
                         nextInstruction.incrementPB();
                    }

              }
            }
        }
        
        
    }
}
