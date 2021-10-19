using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleColor : MonoBehaviour
{
    [SerializeField] private GameObject color;
    [SerializeField] private NextInstruction nextInstruction;
    private float timer = 0.0f;
    private float timerMax = 0.0f;


    private bool colorIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowColor);
        colorIsEnabled = false;
        color.SetActive(colorIsEnabled);
        
    }

    void ShowColor(){
        if(color != null && nextInstruction.instructionIsEnabled5){
        colorIsEnabled ^= true;
        color.SetActive(colorIsEnabled);
        if (Waited(5.0f)){
            nextInstruction.clickable = true;
            nextInstruction.instructionIsEnabled6 = true;
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
