using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectTouch : MonoBehaviour
{
    bool firstTime = true;
    //for the instructions button
    [SerializeField] private AnimalExpInstructions nextInstruction;
    [SerializeField] private AudioSource audioSource;

    //check image enables
    [SerializeField] private GameObject enableCheck;
    [SerializeField] private GameObject lastInstruction,instruction7,endGame,progressBar;

    //animals
    [SerializeField] private GameObject Zebra,horse1,horse2;
    [SerializeField] private GameObject Sheep1,Sheep2,Sheep3;

    //game onject to turn their script
    [SerializeField] private GameObject sraw, tiger, turtle, elephant;

    private bool instructionIsEnabled;
    //tag
    [SerializeField] private string tag;

    private Animator animalAnimation;

    void Start(){
        animalAnimation = gameObject.GetComponent<Animator>();
    }
    // Update is called once per frame
    void Update()
    {   
        
        //Sraws
        if(nextInstruction.instructionIsEnabled3 && tag.Equals("Sraws")){
            Debug.Log("Sraws");
            instructionIsEnabled = nextInstruction.instructionIsEnabled3;
            clicked();
            //enable the turtle detect touch
            turtle.GetComponent<DetectTouch>().enabled = true;
            //turtle
        }else if(nextInstruction.instructionIsEnabled4 && tag.Equals("turtle")){
            Debug.Log("turtle");
            instructionIsEnabled = nextInstruction.instructionIsEnabled4;
            clicked();
            //disable the straw detect touch
            sraw.GetComponent<DetectTouch>().enabled = false;
            //enable the turtle detect touch
            elephant.GetComponent<DetectTouch>().enabled = true;
            //elephant
        }else if(nextInstruction.instructionIsEnabled5 && tag.Equals("elephant")){
            Debug.Log("start --> elephant");
            instructionIsEnabled = nextInstruction.instructionIsEnabled5;
            clicked();
            //disable the straw detect touch
            turtle.GetComponent<DetectTouch>().enabled = false;
            //enable the turtle detect touch
            tiger.GetComponent<DetectTouch>().enabled = true;
            //tiger
        }else if(nextInstruction.instructionIsEnabled6){
            Debug.Log("Tiger");
            instructionIsEnabled = nextInstruction.instructionIsEnabled6;
            clicked();
            //disable the straw detect touch
            elephant.GetComponent<DetectTouch>().enabled = false;
            //enable the turtle detect touch
            horse1.GetComponent<DetectTouch>().enabled = true;
            horse2.GetComponent<DetectTouch>().enabled = true;
            //horse
        }else if(nextInstruction.instructionIsEnabled7 && tag.Equals("horse")){
            Debug.Log("horse");
            instructionIsEnabled = nextInstruction.instructionIsEnabled7;
            lastClicked();
            //disable the tiger detect touch
            tiger.GetComponent<DetectTouch>().enabled = false;
        }else{
            Debug.Log("in update method");
        }
        
     

        

       
        
    }

    public void clicked(){
         Debug.Log("----------inside update "+tag+"---firstTime:"+firstTime+" ------------- nextInstruction.instructionIsEnabled:"+instructionIsEnabled+"");
        if(firstTime && instructionIsEnabled){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update "+tag+" and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                Debug.Log("\n\n\nhit.transform.name??"+hit.transform.gameObject.CompareTag(tag)+"\n\n\n");
                if(nextInstruction.instructionIsEnabled6){
                   
                  if(hit.transform.gameObject.CompareTag("Zebra")){
                     Debug.Log("Tiger attaks Zebra");
                     enableTigerAnimation("attakZebra");
                     enableSound();
                  }else if(hit.transform.gameObject.CompareTag("horse")){
                     Debug.Log("Tiger attaks horse");
                     enableTigerAnimation("attakHorse");
                     enableSound();
                  }else if(hit.transform.gameObject.CompareTag("sheep")){
                      Debug.Log("Tiger attaks sheep");
                     enableTigerAnimation("attakSheep");
                     enableSound();
                  }
                  
                   //after finish the animation
                  // StartCoroutine(delay());
                  // Done();
                           
                }else if(hit.transform.gameObject.CompareTag(tag)){
                     Debug.Log("hi");
                    //if straw
                    if(tag.Equals("Sraws")){
                      Debug.Log("sheep animation");
                      Sheep1.GetComponent<animalDeath>().enableWalk();
                      Sheep2.GetComponent<animalDeath>().enableWalk();
                      Sheep3.GetComponent<animalDeath>().enableWalk();
                     // StartCoroutine(delay());
                     // Done();
                    }else{
                      Done();
                    }
                  
                   
                }

              }
            }
        }
        
    }

    IEnumerator delay() { yield return new WaitForSeconds(9); }

     public void lastClicked(){
         Debug.Log("----------inside update "+tag+"---firstTime:"+firstTime+" ------------- nextInstruction.instructionIsEnabled:"+instructionIsEnabled+"");
        if(firstTime && instructionIsEnabled){
            if(Input.GetMouseButtonDown(0))
             {
               Debug.Log("-----------------inside if statment of update "+tag+" and click----------------");
               Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
               Debug.Log("ray camera: "+ ray);
               RaycastHit hit;
              if(Physics.Raycast(ray, out hit)){
                Debug.Log("\n\n\nhit.transform.name??"+hit.transform.gameObject.CompareTag(tag)+"\n\n\n");
                     if(hit.transform.gameObject.CompareTag(tag)){
                         Debug.Log("hi");
                         firstTime = false;
                         //display next instruction
                         nextInstruction.ShowInstruction();
              
                         //display check icon
                         enableCheck.SetActive(true);

                         //update progress bar
                         nextInstruction.incrementPB();

                        //Exit game
                         Invoke("finished",2);


                    }

              }
            }
        }
        
    }

    void finished(){
        instruction7.SetActive(false);
        lastInstruction.SetActive(true);

        //diable all buttons
        progressBar.SetActive(false);

        //button to end game
        endGame.SetActive(true);
    }

    //called from animation tiger
    void enableAnimation(){
        Zebra.GetComponent<animalDeath>().enableAnimation();
    }
    //called from animation tiger
    void enableAnimationSheep(){
        Sheep1.GetComponent<animalDeath>().enableAnimation();
        Sheep2.GetComponent<animalDeath>().enableAnimation();
    }

    void enableTigerAnimation(string _trigger){
        Debug.Log("\n\t\t*****tiger trigger*****\t\t\n");
        animalAnimation.SetTrigger(_trigger);
    }

    public void Done(){
        firstTime = false;
        //display next instruction
        nextInstruction.ShowInstruction();
              
        //display check icon
        enableCheck.SetActive(true);

        //update progress bar
        nextInstruction.incrementPB();        
    }

    void enableSound(){
        audioSource.Play();
        Debug.Log("\n\t\t*****PouringSoundt*****\t\t\n");
        
    }
}
