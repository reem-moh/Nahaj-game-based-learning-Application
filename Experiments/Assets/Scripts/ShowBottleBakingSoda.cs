using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleBakingSoda : MonoBehaviour
{
    [SerializeField] private GameObject bakingSoda;
    [SerializeField] private NextInstruction nextInstruction;
    private float timer = 0.0f;
    private float timerMax = 0.0f;


    private bool bakingSodaIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowBakingSoda);
        bakingSodaIsEnabled = false;
        bakingSoda.SetActive(bakingSodaIsEnabled);
        
    }

    void ShowBakingSoda(){
        if(bakingSoda != null && nextInstruction.instructionIsEnabled7){
        bakingSodaIsEnabled ^= true;
        bakingSoda.SetActive(bakingSodaIsEnabled);
        nextInstruction.clickable= false;
        //if (Waited(20.0f)){
            //nextInstruction.instructionIsEnabled4 = true;
        //}
        }
    }
    private bool Waited(float seconds){
     timerMax = seconds;
 
     timer += Time.deltaTime;
 
    if (timer >= timerMax)
    {
        return true; //max reached - waited x - seconds
    }
 
    return false;
}
}

