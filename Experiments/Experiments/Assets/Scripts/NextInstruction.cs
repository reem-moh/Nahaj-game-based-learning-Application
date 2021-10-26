using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class NextInstruction : MonoBehaviour
{
    [SerializeField] private GameObject instruction1,instruction2,instruction3,instruction4,instruction5,instruction6,instruction7,instruction8;
    //to show the next instruction
    [HideInInspector]
    public bool instructionIsEnabled1, instructionIsEnabled2,instructionIsEnabled3,instructionIsEnabled4,instructionIsEnabled5,instructionIsEnabled6,instructionIsEnabled7;
    //to enable click on ingredients buttons
    [HideInInspector]
    public bool showWater3, showVinegar4,showColor5,showSoap6,showBakingSoda7;
    //to enable clicking on the next button
    [HideInInspector]
    public bool clickable = true;

    public RectTransform rt;
    
    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowInstruction);
        showWater3 = false;
        showVinegar4 = false;
        showColor5 = false;
        showSoap6 = false;
        showBakingSoda7 = false;
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
        if(clickable){
        if(instructionIsEnabled1 && instruction1!=null && instruction2!=null){
            instructionIsEnabled1 = false;
            instructionIsEnabled2 = true;
            instruction1.SetActive(instructionIsEnabled1);
            instruction2.SetActive(instructionIsEnabled2);
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-176f,82f,0f);
        }else 
        //show water instruction
        if (instructionIsEnabled2 && instruction2!=null && instruction3!=null)
        {
            instructionIsEnabled2 = false;
            instructionIsEnabled3 = true;
            //enable click on مياه button
            showWater3=true;
            instruction2.SetActive(instructionIsEnabled2);
            instruction3.SetActive(instructionIsEnabled3);
            clickable = false;
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-24.8811f,-23.84338f,0f);
        }else 
        //show venigar instruction
        if (instructionIsEnabled3 && instruction3!=null && instruction4!=null)
        {
            instructionIsEnabled3 = false;
            instructionIsEnabled4 = true;
            //disable click on مياه button
            showWater3=false;
            //enable click on خل button
            showVinegar4=true;
            instruction3.SetActive(instructionIsEnabled3);
            instruction4.SetActive(instructionIsEnabled4);
            clickable = false;
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-24.8811f,-23.84338f,0f);
        }else 
        //show food color instruction
        if (instructionIsEnabled4 && instruction4!=null && instruction5!=null)
        {
            instructionIsEnabled4 = false;
            instructionIsEnabled5 = true;
            //disable click on خل button
            showVinegar4=false;
            //enable click on ملون طعام button
            showColor5=true;
            instruction4.SetActive(instructionIsEnabled4);
            instruction5.SetActive(instructionIsEnabled5);
            clickable = false;
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-24.8811f,-23.84338f,0f);
        }else 
        //show soap instruction
        if (instructionIsEnabled5 && instruction5!=null && instruction6!=null)
        {
            instructionIsEnabled5 = false;
            instructionIsEnabled6 = true;
            //disable click on ملون طعام button
            showColor5=false;
            //enable click on صابون button
            showSoap6=true;
            instruction5.SetActive(instructionIsEnabled5);
            instruction6.SetActive(instructionIsEnabled6);
            clickable = false;
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-24.8811f,-23.84338f,0f);
        }else 
        //show baking soda instruction
        if (instructionIsEnabled6 && instruction6!=null && instruction7!=null)
        {
            instructionIsEnabled6 = false;
            instructionIsEnabled7 = true;
            //disable click on صابون button
            showSoap6=false;
            //enable click on بيكربونات الصوديوم button
            showBakingSoda7=true;
            instruction6.SetActive(instructionIsEnabled6);
            instruction7.SetActive(instructionIsEnabled7);
            clickable = false;
            //move position of arrow to rightcorner screen
            rt.anchoredPosition3D=new Vector3(-24.8811f,-23.84338f,0f);
        }else
        if(instructionIsEnabled7){
            //disable click on بيكربونات الصوديوم button
            showBakingSoda7=false;
            clickable = false;
            instruction7.SetActive(false);
            //after finish the experiment
            
            Destroy(gameObject);
            
        }
    }
}

    public void enableClickable(){
        clickable = true;
    }

}
