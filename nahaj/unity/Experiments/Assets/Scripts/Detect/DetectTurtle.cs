using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectTurtle : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //game onject to turn their script
    [SerializeField] private GameObject sraw, elephant;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(nextInstruction.instructionIsEnabled4){
            //disable the straw detect touch
            sraw.GetComponent<DetectSheep>().enabled = false;
            clicked();
        }
    }

    public void clicked(){
         Debug.Log("----------inside update Turtule "+tag+"---firstTime:"+firstTime+"");
        if(firstTime){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                  if(hit.transform.gameObject.CompareTag(tag)){
                    Debug.Log("Turtule");
                    Done();
                  }
              }
            }
        }
        
    }

    //called from sheep 1 script
    public void Done(){
        firstTime = false;
        //display next instruction
        nextInstruction.ShowInstruction();
              
        //display check icon
        enableCheck.SetActive(true);

        //update progress bar
        nextInstruction.incrementPB(); 
        
        //enable next animal
        elephant.GetComponent<DetectElephant>().enabled = true;     
    }
}
