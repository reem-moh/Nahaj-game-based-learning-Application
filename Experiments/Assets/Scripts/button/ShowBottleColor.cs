using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottleColor : MonoBehaviour
{
    [SerializeField] private GameObject color;
    [SerializeField] private NextInstruction nextInstruction;

    private bool colorIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowColor);
        colorIsEnabled = false;
        color.SetActive(colorIsEnabled);
        
    }

    void ShowColor(){
        if(color!= null && nextInstruction.showColor5){
            colorIsEnabled ^= true;
            color.SetActive(colorIsEnabled);
        }

    }
}
