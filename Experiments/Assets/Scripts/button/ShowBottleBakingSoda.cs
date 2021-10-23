using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleBakingSoda : MonoBehaviour
{
    [SerializeField] private GameObject bakingSoda;
    [SerializeField] private NextInstruction nextInstruction;

    private bool bakingSodaIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowBakingSoda);
        bakingSodaIsEnabled = false;
        bakingSoda.SetActive(bakingSodaIsEnabled);
        
    }

    void ShowBakingSoda(){
        if(bakingSoda != null && nextInstruction.showBakingSoda7){
            bakingSodaIsEnabled ^= true;
            bakingSoda.SetActive(bakingSodaIsEnabled);
        }
        
    }
}

