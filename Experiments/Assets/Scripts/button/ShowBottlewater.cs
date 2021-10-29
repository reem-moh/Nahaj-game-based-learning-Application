using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottlewater : MonoBehaviour
{
    [SerializeField] private GameObject water;
    [SerializeField] private NextInstruction nextInstruction;

    private bool waterIsEnabled;

    //for audio
    private AudioSource audioSource;
    [SerializeField] private AudioClip clickableBtn;
    [SerializeField] private AudioClip unclickableBtn;
    //[SerializeField] private NextInstruction nextInstruction;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowWater);
        waterIsEnabled = false;
        water.SetActive(waterIsEnabled);
        audioSource = GetComponent<AudioSource>();
        
    }

    void ShowWater(){
        if(water != null && nextInstruction.showWater3){
         waterIsEnabled ^= true;
         water.SetActive(waterIsEnabled);

        }
        
    }

    public void clicked(){
        if(water != null && nextInstruction.showWater3){
            audioSource.PlayOneShot(clickableBtn);
            //sound click
        }else{
            //sound error
            audioSource.PlayOneShot(unclickableBtn);
        }
    }
}
