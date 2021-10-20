using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class NextInstruction : MonoBehaviour
{
    [SerializeField] private GameObject instruction1,instruction2,instruction3,instruction4,instruction5,instruction6,instruction7;
    [HideInInspector]
    public bool instructionIsEnabled1, instructionIsEnabled2,instructionIsEnabled3,instructionIsEnabled4,instructionIsEnabled5,instructionIsEnabled6,instructionIsEnabled7;
    
    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowInstruction);
        instructionIsEnabled1 = true;
        instructionIsEnabled2 = false;
        instructionIsEnabled3 = false;
        instructionIsEnabled4 = false;
        instructionIsEnabled5 = false;
        instructionIsEnabled6 = false;
        instructionIsEnabled7 = false;
        instruction1.SetActive(instructionIsEnabled1);
        instruction2.SetActive(instructionIsEnabled2);
        instruction3.SetActive(instructionIsEnabled3);
        instruction4.SetActive(instructionIsEnabled4);
        instruction5.SetActive(instructionIsEnabled5);
        instruction6.SetActive(instructionIsEnabled6);
        instruction7.SetActive(instructionIsEnabled7);
    }

    void ShowInstruction(){
        if(instructionIsEnabled1 && instruction1!=null && instruction2!=null){
            instructionIsEnabled1 = false;
            instructionIsEnabled2 = true;
            instruction1.SetActive(instructionIsEnabled1);
            instruction2.SetActive(instructionIsEnabled2);
        }else if (instructionIsEnabled2 && instruction2!=null && instruction3!=null)
        {
            instructionIsEnabled2 = false;
            instructionIsEnabled3 = true;
            instruction2.SetActive(instructionIsEnabled2);
            instruction3.SetActive(instructionIsEnabled3);
        }else if (instructionIsEnabled3 && instruction3!=null && instruction4!=null)
        {
            instructionIsEnabled3 = false;
            //instructionIsEnabled4 = true;
            instruction3.SetActive(instructionIsEnabled3);
            instruction4.SetActive(instructionIsEnabled4);
        }else if (instructionIsEnabled4 && instruction4!=null && instruction5!=null)
        {
            instructionIsEnabled4 = false;
            //instructionIsEnabled5 = true;
            instruction4.SetActive(instructionIsEnabled4);
            instruction5.SetActive(instructionIsEnabled5);
        }else if (instructionIsEnabled5 && instruction5!=null && instruction6!=null)
        {
            instructionIsEnabled5 = false;
            //instructionIsEnabled6 = true;
            instruction5.SetActive(instructionIsEnabled5);
            instruction6.SetActive(instructionIsEnabled6);
        }else if (instructionIsEnabled6 && instruction6!=null && instruction7!=null)
        {
            instructionIsEnabled6 = false;
            //instructionIsEnabled7 = true;
            instruction6.SetActive(instructionIsEnabled6);
            instruction7.SetActive(instructionIsEnabled7);
        }
    }
}
