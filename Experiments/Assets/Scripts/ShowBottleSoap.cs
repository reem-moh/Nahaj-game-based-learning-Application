using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleSoap : MonoBehaviour
{
    [SerializeField] private GameObject soap;
    [SerializeField] private NextInstruction nextInstruction;
    private float timer = 0.0f;
    private float timerMax = 0.0f;


    private bool soapIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowSoap);
        soapIsEnabled = false;
        soap.SetActive(soapIsEnabled);
        
    }

    void ShowSoap(){
        if(soap != null && nextInstruction.instructionIsEnabled6){
        soapIsEnabled ^= true;
        soap.SetActive(soapIsEnabled);
        if (Waited(5.0f)){
            nextInstruction.clickable = true;
            nextInstruction.instructionIsEnabled7 = true;
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
