using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleSoap : MonoBehaviour
{
    [SerializeField] private GameObject soap;

    private bool soapIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowSoap);
        soapIsEnabled = false;
        soap.SetActive(soapIsEnabled);
        
    }

    void ShowSoap(){
        if(soap!= null){
            soapIsEnabled ^= true;
            soap.SetActive(soapIsEnabled);
        }
        
    }
}
