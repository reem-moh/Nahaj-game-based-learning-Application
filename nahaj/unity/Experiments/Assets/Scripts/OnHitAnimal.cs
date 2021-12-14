using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using Vuforia;
using UnityEngine.SceneManagement;
 
 public class OnHitAnimal : MonoBehaviour 
 {
     [SerializeField] private GameObject firstInstruction,arrow;
     [SerializeField] private float timeToInvokeInstrucation;

     Scene scene;

     void Start()
    {
           print("\n\n\n\n1 in satrt onHit\n\n\n\n");
        scene = SceneManager.GetActiveScene();
       // if(scene.buildIndex == 1){
        var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
        var planeBehaviour = GetComponent<PlaneFinderBehaviour>();
        print("\n\n\n\n2 in satrt onHit\n\n\n\n");
        //if (listenerBehaviour != null)
        //{
            Vector2 pos = new Vector2(0, 0);
            planeBehaviour.PerformHitTest(pos);
            listenerBehaviour.enabled = false;
            planeBehaviour.PlaneIndicator.SetActive(false);
            print("\n\n\n\n3 in satrt onHit\n\n\n\n");
            Invoke("showInstruction",timeToInvokeInstrucation);
        //}
       // }
    }


    void showInstruction(){

        firstInstruction.SetActive(true);
        arrow.SetActive(true);
    }

 }