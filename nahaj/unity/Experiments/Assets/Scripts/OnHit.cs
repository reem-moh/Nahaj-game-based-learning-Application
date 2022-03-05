using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using Vuforia;
using UnityEngine.SceneManagement;
 
 public class OnHit : MonoBehaviour 
 {
     [SerializeField] private GameObject clickOnScrean,firstInstruction,arrow;
     [SerializeField] private float timeToInvokeInstrucation;

     Scene scene;
   
     public void OnInteractiveHitTest(HitTestResult result)
    {
        var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
       // var planeBehaviour = GetComponent<PlaneFinderBehaviour>();
        if (listenerBehaviour != null)
        {
            listenerBehaviour.enabled = false;
            //planeBehaviour.PlaneIndicator.SetActive(false);
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