using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class countdownController : MonoBehaviour
{
     public int countdownTime;
     public GameObject p1;
     public GameObject p2;
     public GameObject p3;
     public explosion explosion;

     private string p;
     private string time;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(countdownToStart());
    }

    IEnumerator countdownToStart(){
        
        while(countdownTime > 0){
            //convert time to string
            time = countdownTime.ToString();
            //display image
            p = "p" + time ;

            switch(p){
                case "p1":  p1.SetActive(true);
                            p2.SetActive(false);
                            p3.SetActive(false);
                            break;

                case "p2": p1.SetActive(false);
                           p2.SetActive(true);
                           p3.SetActive(false);
                           break;

                case "p3": p1.SetActive(false);
                           p2.SetActive(false);
                           p3.SetActive(true);
                           break;
            }
            //wait for one second
            yield return new WaitForSeconds(1f);
            //decrement
            countdownTime--;
             

        }

        //turn off all images;
        p1.SetActive(false);
        p2.SetActive(false);
        p3.SetActive(false);
        
        //wait for one second
        yield return new WaitForSeconds(1f);

        explosion.explode();

    }
}
