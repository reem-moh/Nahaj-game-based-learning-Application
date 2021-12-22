using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectElephant : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //game onject to turn their script
    [SerializeField] private GameObject turtle, tiger;

    //for audio
    [SerializeField] private AudioSource click;
    [SerializeField] private AudioSource wrongClick;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(nextInstruction.instructionIsEnabled5){
            //disable the straw detect touch
            turtle.GetComponent<DetectTurtle>().enabled = false;
            clicked();
        }
    }

    public void clicked(){
         Debug.Log("----------inside update elephant "+tag+"---firstTime:"+firstTime+"");
        if(firstTime){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                if(hit.transform.gameObject.CompareTag(tag)){
                    Debug.Log("elephant");
                    Done();
                     click.Play();
                }else{
                    //sound error
                    wrongClick.Play();;
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
        tiger.GetComponent<DetectTiger>().enabled = true;     
    }
}

