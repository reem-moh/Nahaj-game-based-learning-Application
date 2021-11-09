using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Waiter: MonoBehaviour
{
    private float timer = 0.0f;
    private float timerMax = 0.0f;
    
    public bool Waited(float seconds){
     timerMax = seconds;
    while (timer < timerMax)
    {
         timer += Time.deltaTime;
         print("\n\n\n"+timer+"\n\n\n");
    }
 
    if (timer >= timerMax)
    {
        timer = 0.0f;
        return true; //max reached - waited x - seconds
    }
 
    return false;
}
}
