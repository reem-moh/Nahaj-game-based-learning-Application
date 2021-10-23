using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleVinegar : MonoBehaviour
{
    [SerializeField] private GameObject vinegar;
    [SerializeField] private NextInstruction nextInstruction;

    private bool vinegarIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowVinegar);
        vinegarIsEnabled = false;
        vinegar.SetActive(vinegarIsEnabled);
        
    }

    void ShowVinegar(){
        if(vinegar != null && nextInstruction.showVinegar4){
            vinegarIsEnabled ^= true;
            vinegar.SetActive(vinegarIsEnabled);
        } 
    }
}
