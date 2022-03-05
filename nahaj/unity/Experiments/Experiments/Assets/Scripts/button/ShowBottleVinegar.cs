using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleVinegar : MonoBehaviour
{
    [SerializeField] private GameObject vinegar;
    [SerializeField] private NextInstruction nextInstruction;

    private bool vinegarIsEnabled;
    //for audio
    private AudioSource audioSource;
    [SerializeField] private AudioClip clickableBtn;
    [SerializeField] private AudioClip unclickableBtn;
    //[SerializeField] private NextInstruction nextInstruction;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowVinegar);
        vinegarIsEnabled = false;
        vinegar.SetActive(vinegarIsEnabled);
        audioSource = GetComponent<AudioSource>();
        
    }

    void ShowVinegar(){
        if(vinegar != null && nextInstruction.showVinegar4){
            vinegarIsEnabled ^= true;
            vinegar.SetActive(vinegarIsEnabled);
        } 
    }

    public void clicked(){
        if(nextInstruction.showVinegar4){
            audioSource.PlayOneShot(clickableBtn);
            //sound click
        }else{
            //sound error
            audioSource.PlayOneShot(unclickableBtn);
        }
    }
}
