using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectSheep : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //animals
    [SerializeField] private GameObject Sheep1,Sheep2,Sheep3;

    //game object to turn their script
    [SerializeField] private GameObject turtle;

    //tag
    [SerializeField] private string tag;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(nextInstruction.instructionIsEnabled3){
            clicked();
        }
    }

    public void clicked(){
         Debug.Log("----------inside update sheep ---firstTime:"+firstTime+"");
        if(firstTime){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                if(hit.transform.gameObject.CompareTag(tag)){
                  Debug.Log("sheep animation");
                  Sheep1.GetComponent<animalDeath>().enableWalk();
                  Sheep2.GetComponent<animalDeath>().enableWalk();
                  Sheep3.GetComponent<animalDeath>().enableWalk();
                }
              }
            }
        }
        
    }

    //called from sheep 1 script
    public void Done(){
        if(firstTime){
            firstTime = false;
            //display next instruction
            nextInstruction.ShowInstruction();
              
            //display check icon
            enableCheck.SetActive(true);

            //update progress bar
            nextInstruction.incrementPB(); 
        
            //enable next animal
            turtle.GetComponent<DetectTurtle>().enabled = true; 
        }
              
    }
}
