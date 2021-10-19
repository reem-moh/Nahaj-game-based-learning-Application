using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleVinegar : MonoBehaviour
{
    [SerializeField] private GameObject vinegar;
    [SerializeField] private NextInstruction nextInstruction;
    private float timer = 0.0f;
    private float timerMax = 0.0f;


    private bool vinegarIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowVinegar);
        vinegarIsEnabled = false;
        vinegar.SetActive(vinegarIsEnabled);
        
    }

    void ShowVinegar(){
        if(vinegar != null && nextInstruction.instructionIsEnabled4){
            vinegarIsEnabled ^= true;
        vinegar.SetActive(vinegarIsEnabled);
        if (Waited(5.0f)){
            nextInstruction.clickable = true;
            nextInstruction.instructionIsEnabled5 = true;
        }
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
