using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottlewater : MonoBehaviour
{
    [SerializeField] private GameObject water;
    [SerializeField] private NextInstruction nextInstruction;
    private float timer = 0.0f;
    private float timerMax = 0.0f;

    private bool waterIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowWater);
        waterIsEnabled = false;
        water.SetActive(waterIsEnabled);
        
        
    }

    void ShowWater(){
        if(water != null && nextInstruction.instructionIsEnabled3){
         waterIsEnabled ^= true;
         water.SetActive(waterIsEnabled);
        if (Waited(5.0f)){
            nextInstruction.clickable = true;
            nextInstruction.instructionIsEnabled4 = true;
        }
        }
        
    }
    private bool Waited(float seconds)
{
     timerMax = seconds;
 
     timer += Time.deltaTime;
 
    if (timer >= timerMax)
    {
        return true; //max reached - waited x - seconds
    }
 
    return false;
}
}
