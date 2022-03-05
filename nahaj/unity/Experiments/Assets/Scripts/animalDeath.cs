using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class animalDeath : MonoBehaviour
{
    private Animator animalAnimation;
    [SerializeField] private GameObject sraw;
    private bool firstTime;

    // Start is called before the first frame update
    void Start()
    {
        animalAnimation = gameObject.GetComponent<Animator>();
        firstTime= true;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void enableAnimation(){
        Debug.Log("\n\t\t*****die trigger*****\t\t\n");
        animalAnimation.SetTrigger("die");
    }

    public void enableWalk(){
        Debug.Log("\n\t\t*****walk trigger*****\t\t\n");
        animalAnimation.SetTrigger("walk");
    }

    //called from sheep1 eat 
    public void Done(){
        if(firstTime){
            sraw.GetComponent<DetectSheep>().Done();
            firstTime = false;
            //turn of the code
            sraw.GetComponent<DetectSheep>().enabled = false;
        }
        
    }
}
