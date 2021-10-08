using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using Vuforia;
 
 public class OnHit : MonoBehaviour 
 {
     public void OnInteractiveHitTest(HitTestResult result)
{
    var listenerBehaviour = GetComponent<AnchorInputListenerBehaviour>();
    if (listenerBehaviour != null)
    {
        listenerBehaviour.enabled = false;
    }
 }

 }