using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class exitGame : MonoBehaviour
{
    // Start is called before the first frame update
    UnityMessageManager mssgManag;
    [SerializeField] private GameObject buttonEnd;
    [SerializeField] private GameObject instruction;

    void Start(){
        mssgManag = GetComponent<UnityMessageManager>();
    }
    // Start is called before the first frame update
    public void EndGame(){
        
        print("inside unity script end game");
        instruction.SetActive(false);
        buttonEnd.SetActive(false);
        mssgManag.SendMessageToFlutter("END");
    }
}
