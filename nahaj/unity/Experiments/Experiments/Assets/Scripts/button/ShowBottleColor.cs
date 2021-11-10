using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleColor : MonoBehaviour
{
    [SerializeField] private GameObject color;
    [SerializeField] private NextInstruction nextInstruction;

    private bool colorIsEnabled;

    //for audio
    private AudioSource audioSource;
    [SerializeField] private AudioClip clickableBtn;
    [SerializeField] private AudioClip unclickableBtn;
    //[SerializeField] private NextInstruction nextInstruction;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowColor);
        colorIsEnabled = false;
        color.SetActive(colorIsEnabled);
        audioSource = GetComponent<AudioSource>();
        
    }

    void ShowColor(){
        if(color!= null && nextInstruction.showColor5){
            colorIsEnabled ^= true;
            color.SetActive(colorIsEnabled);
        }

    }

    public void clicked(){
        if(nextInstruction.showColor5){
            audioSource.PlayOneShot(clickableBtn);
            //sound click
        }else{
            //sound error
            audioSource.PlayOneShot(unclickableBtn);
        }
    }
}
