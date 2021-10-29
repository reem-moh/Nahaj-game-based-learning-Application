using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using Vuforia;
 
 public class OnHit : MonoBehaviour 
 {
     [SerializeField] private GameObject clickOnScrean,firstInstruction,arrow;
     [SerializeField] private float timeToInvokeInstrucation;
     

     public void OnInteractiveHitTest(HitTestResult result)
    {
        var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
        if (listenerBehaviour != null)
        {
            listenerBehaviour.enabled = false;
            //disable image 
            //clickOnScrean.SetActive(false);
            Destroy(clickOnScrean);
            Invoke("showInstruction",timeToInvokeInstrucation);
        }
    }

    void showInstruction(){

        firstInstruction.SetActive(true);
        arrow.SetActive(true);
    }

 }