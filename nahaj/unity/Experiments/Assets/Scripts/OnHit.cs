using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using Vuforia;
using UnityEngine.SceneManagement;
 
 public class OnHit : MonoBehaviour 
 {
     [SerializeField] private GameObject clickOnScrean,firstInstruction,arrow;
     [SerializeField] private float timeToInvokeInstrucation;
     
    // Start is called before the first frame update
    void Start()
    {
        /*Scene scene = SceneManager.GetActiveScene();
        if(scene.name == 'Scenes/AnimalExperiment'){

        }*/
        var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
        var planeBehaviour = GetComponent<PlaneFinderBehaviour>();
        print("\n\n\n\nin satrt onHit\n\n\n\n");
        if (listenerBehaviour != null)
        {
            listenerBehaviour.enabled = false;
            planeBehaviour.PlaneIndicator.SetActive(false);
            print("\n\n\n\n1 in satrt onHit\n\n\n\n");
            //disable image 
            //clickOnScrean.SetActive(false);
            Destroy(clickOnScrean);
            //Invoke("showInstruction",timeToInvokeInstrucation);
        }
    }


     public void OnInteractiveHitTest(HitTestResult result)
    {
        var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
        if (listenerBehaviour != null)
        {
            listenerBehaviour.enabled = false;
            //disable image 
            //clickOnScrean.SetActive(false);
            Destroy(clickOnScrean);
            //Invoke("showInstruction",timeToInvokeInstrucation);
        }
    }

    void showInstruction(){

        firstInstruction.SetActive(true);
        arrow.SetActive(true);
    }

 }