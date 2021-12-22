using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectHorse : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //game onject to turn their script
    [SerializeField] private GameObject Tiger;

    //instruction
    [SerializeField] private GameObject lastInstruction,endGame,progressBar;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(nextInstruction.instructionIsEnabled7){
            //disable the straw detect touch
            Tiger.GetComponent<DetectTiger>().enabled = false;
            clicked();
        }
    }

    public void clicked(){
         Debug.Log("----------inside update horse ---firstTime:"+firstTime+"");
        if(firstTime){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                  if(hit.transform.gameObject.CompareTag(tag)){
                    Debug.Log("horse");
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
        
        finished();
    }

    void finished(){

        //diable all buttons
        progressBar.SetActive(false);

        //button to end game
        lastInstruction.SetActive(true);
        endGame.SetActive(true);
    }
}

