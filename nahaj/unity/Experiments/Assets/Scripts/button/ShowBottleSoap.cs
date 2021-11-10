using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleSoap : MonoBehaviour
{
    [SerializeField] private GameObject soap;
    [SerializeField] private NextInstruction nextInstruction;

    private bool soapIsEnabled;

    //for audio
    private AudioSource audioSource;
    [SerializeField] private AudioClip clickableBtn;
    [SerializeField] private AudioClip unclickableBtn;
    //[SerializeField] private NextInstruction nextInstruction;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowSoap);
        soapIsEnabled = false;
        soap.SetActive(soapIsEnabled);
        audioSource = GetComponent<AudioSource>();
    }

    void ShowSoap(){
        if(soap!= null && nextInstruction.showSoap6){
            soapIsEnabled ^= true;
            soap.SetActive(soapIsEnabled);
        }
        
    }

    public void clicked(){
        if(nextInstruction.showSoap6){
            audioSource.PlayOneShot(clickableBtn);
            //sound click
        }else{
            //sound error
            audioSource.PlayOneShot(unclickableBtn);
        }
    }
}
