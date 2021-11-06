using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    //To communicate with flutter
    public UnityMessageManager unityMsgMngr;
    public SceneLoader sceneMngr;
    void Start()
    {
        unityMsgMngr = gameObject.GetComponent<UnityMessageManager>();
        sceneMngr.LoadScene(0);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
