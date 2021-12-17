using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class AnimalExpInstructions : MonoBehaviour
{
    [SerializeField] private GameObject instruction1,instruction2,instruction3,instruction4,instruction5,instruction6,instruction7;

    [HideInInspector]
    public bool instructionIsEnabled1, instructionIsEnabled2,instructionIsEnabled3,instructionIsEnabled4,instructionIsEnabled5,instructionIsEnabled6,instructionIsEnabled7;
    
    //progress bar
    [SerializeField] private GameObject pb0,pb1,pb2,pb3,pb4,pb5;

    //to show the next progress bar
    [HideInInspector]
    public bool pbEnabled0, pbEnabled1, pbEnabled2,pbEnabled3,pbEnabled4,pbEnabled5;
    
    [HideInInspector]
    public bool clickable;
    //for arrow
    public RectTransform rt;
    public Image arrow;
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
        //enable progress bar 0 at the start
        pbEnabled0 = true;
        pbEnabled1 = false;
        pbEnabled2 = false;
        pbEnabled3 = false;
        pbEnabled4 = false;
        pbEnabled5 = false;
        pb0.SetActive(pbEnabled0);
        pb1.SetActive(pbEnabled1);
        pb2.SetActive(pbEnabled2);
        pb3.SetActive(pbEnabled3);
        pb4.SetActive(pbEnabled4);
        pb5.SetActive(pbEnabled5);

        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void ShowInstruction(){
         if(instructionIsEnabled1 && instruction1!=null && instruction2!=null){
            instructionIsEnabled1 = false;
            instructionIsEnabled2 = true;
            instruction1.SetActive(instructionIsEnabled1);
            instruction2.SetActive(instructionIsEnabled2);
             
            rt.anchoredPosition3D=new Vector3(-176f,82f,0f);
        }else 
        //show first question
        if (instructionIsEnabled2 && instruction2!=null && instruction3!=null)
        {
            instructionIsEnabled2 = false;
            instructionIsEnabled3 = true;
            instruction2.SetActive(instructionIsEnabled2);
            instruction3.SetActive(instructionIsEnabled3);
            //move position of arrow to rightcorner screen
            arrow.enabled = false;
            //rt.anchoredPosition3D=new Vector3(-39.9000015f,15f,0f);
            
        }else 
        //show second question
        if (instructionIsEnabled3 && instruction3!=null && instruction4!=null)
        {
            instructionIsEnabled3 = false;
            instructionIsEnabled4 = true;
            instruction3.SetActive(instructionIsEnabled3);
            instruction4.SetActive(instructionIsEnabled4);
            //move position of arrow to rightcorner screen
           //rt.anchoredPosition3D=new Vector3(-39.9000015f,15f,0f);
        }else 
        //show third question
        if (instructionIsEnabled4 && instruction4!=null && instruction5!=null)
        {
            instructionIsEnabled4 = false;
            instructionIsEnabled5 = true;
            instruction4.SetActive(instructionIsEnabled4);
            instruction5.SetActive(instructionIsEnabled5);
            //move position of arrow to rightcorner screen
           //rt.anchoredPosition3D=new Vector3(-39.9000015f,15f,0f);
        }else 
        //show fourth question
        if (instructionIsEnabled5 && instruction5!=null && instruction6!=null)
        {
            instructionIsEnabled5 = false;
            instructionIsEnabled6 = true;
            instruction5.SetActive(instructionIsEnabled5);
            instruction6.SetActive(instructionIsEnabled6);
            //move position of arrow to rightcorner screen
           //rt.anchoredPosition3D=new Vector3(-39.9000015f,15f,0f);
        }else 
        //show baking soda instruction
        if (instructionIsEnabled6 && instruction6!=null && instruction7!=null)
        {
            instructionIsEnabled6 = false;
            instructionIsEnabled7 = true;
            instruction6.SetActive(instructionIsEnabled6);
            instruction7.SetActive(instructionIsEnabled7);
            //move position of arrow to rightcorner screen
            //rt.anchoredPosition3D=new Vector3(-39.9000015f,15f,0f);

        }else
        if(instructionIsEnabled7){
            
            instruction7.SetActive(false);
            //after finish the experiment
           // Destroy(gameObject);
            
        }
    }

    public void incrementPB(){
        if(pbEnabled0 && pb0 != null && pb1 != null){
            pbEnabled0 = false;
            pbEnabled1 = true;
            pb0.SetActive(pbEnabled0);
            pb1.SetActive(pbEnabled1);
        }else if(pbEnabled1 && pb1 != null && pb2 != null){
            pbEnabled1 = false;
            pbEnabled2 = true;
            pb1.SetActive(pbEnabled1);
            pb2.SetActive(pbEnabled2);
        }else if(pbEnabled2 && pb2 != null && pb3 != null){
            pbEnabled2 = false;
            pbEnabled3 = true;
            pb2.SetActive(pbEnabled2);
            pb3.SetActive(pbEnabled3);
        }else if(pbEnabled3 && pb3 != null && pb4 != null){
            pbEnabled3 = false;
            pbEnabled4 = true;
            pb3.SetActive(pbEnabled3);
            pb4.SetActive(pbEnabled4);
        }else if(pbEnabled4 && pb4 != null && pb5 != null){
            pbEnabled4 = false;
            pbEnabled5 = true;
            pb4.SetActive(pbEnabled4);
            pb5.SetActive(pbEnabled5);
        }
    }
}
