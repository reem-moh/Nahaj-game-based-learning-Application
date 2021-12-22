using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectTiger : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;
    [SerializeField] private AudioSource audioSource;

    //check image enables
    [SerializeField] private GameObject enableCheck;

    //game onject to turn their script
    [SerializeField] private GameObject elephant, horse;

    //animals
    [SerializeField] private GameObject Sheep1,Sheep2,Zebra;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(nextInstruction.instructionIsEnabled6){
            //disable the straw detect touch
            elephant.GetComponent<DetectElephant>().enabled = false;
            clicked();
        }
    }

    public void clicked(){
         Debug.Log("----------inside update tiger ---firstTime:"+firstTime+"");
        if(firstTime){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                Debug.Log("tiger");
                if(hit.transform.gameObject.CompareTag("Zebra")){
                     Debug.Log("Tiger attaks Zebra");
                     enableTigerAnimation("attakZebra");
                     enableSound();

                }else if(hit.transform.gameObject.CompareTag("sheep")){
                      Debug.Log("Tiger attaks sheep");
                     enableTigerAnimation("attakSheep");
                     enableSound();
                }
              }
            }
        }
        
    }

    //called from animation tiger
    public void Done(){
        if(firstTime){
            Debug.Log("-----------------inside Done method 1111111111----------------");
            firstTime = false;
            //display next instruction
            nextInstruction.ShowInstruction();
              
            //display check icon
            enableCheck.SetActive(true);

            //update progress bar
            nextInstruction.incrementPB(); 
        
            //enable next animal
            horse.GetComponent<DetectHorse>().enabled = true; 
        }     
    }

    //called from animation tiger
    void enableAnimation(){
        Zebra.GetComponent<animalDeath>().enableAnimation();
    }
    //called from animation tiger
    void enableAnimationSheep(){
        Sheep1.GetComponent<animalDeath>().enableAnimation();
        //Sheep2.GetComponent<animalDeath>().enableAnimation();
    }

    void enableTigerAnimation(string _trigger){
        Debug.Log("\n\t\t*****tiger trigger*****\t\t\n");
        gameObject.GetComponent<Animator>().SetTrigger(_trigger);
    }

    void enableSound(){
        audioSource.Play();
        Debug.Log("\n\t\t*****PouringSoundt*****\t\t\n");
        
    }
}

