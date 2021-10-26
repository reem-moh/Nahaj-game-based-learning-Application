using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleBakingSoda : MonoBehaviour
{
    [SerializeField] private GameObject bakingSoda;
    [SerializeField] private NextInstruction nextInstruction;

    private bool bakingSodaIsEnabled;

    //for audio
    private AudioSource audioSource;
    [SerializeField] private AudioClip clickableBtn;
    [SerializeField] private AudioClip unclickableBtn;
    //[SerializeField] private NextInstruction nextInstruction;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowBakingSoda);
        bakingSodaIsEnabled = false;
        bakingSoda.SetActive(bakingSodaIsEnabled);
        audioSource = GetComponent<AudioSource>();
    }

    void ShowBakingSoda(){
        if(bakingSoda != null && nextInstruction.showBakingSoda7){
            bakingSodaIsEnabled ^= true;
            bakingSoda.SetActive(bakingSodaIsEnabled);
        }
        
    }

    public void clicked(){
        if(nextInstruction.showBakingSoda7){
            audioSource.PlayOneShot(clickableBtn);
            //sound click
        }else{
            //sound error
            audioSource.PlayOneShot(unclickableBtn);
        }
    }

}

