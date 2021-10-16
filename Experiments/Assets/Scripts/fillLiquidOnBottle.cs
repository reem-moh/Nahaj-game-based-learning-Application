using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class fillLiquidOnBottle : MonoBehaviour
{
    Animator liquidSize;

    [SerializeField] private GameObject InkBottleLiquid;

    bool doneLiquidSize;
    bool beginPourWater;
 
    void Start()
    {
        liquidSize = gameObject.GetComponent<Animator>();
        doneLiquidSize = false;
        beginPourWater = false;
    }

    void Update()
    {

        /*if (Input.GetMouseButtonDown(0))
                {
            
                // liquidSize.SetTrigger("PourActivate");

                 }
          */       
        /*if(doneLiquidSize && !beginPourWater){
            //check user put on wrong position
            if(InkBottleLiquid.GetComponent<Transform>().position.y == 100){
                print("inside position y = 100");
                //liquidSize.SetTrigger("wrongSize");
                liquidSize.SetTrigger("rightSize");
                beginPourWater = true;

                doneLiquidSize = false;
            }else{
                print("inside position y != 100");
                liquidSize.SetTrigger("rightSize");
            }

        }else{

            if(!doneLiquidSize){
                if(Input.touchCount>0){


                }
                if (Input.GetMouseButtonDown(0))
                {
            
                 liquidSize.SetTrigger("isEnabled");

                 }
            }

            if(beginPourWater){
                if (Input.GetMouseButtonDown(0))
                {
            
                 liquidSize.SetTrigger("PourActivate");

                 }

            }
            
        }*/

    }

    //method invoke when user press on right place
    public void endLiquidSize(){
        doneLiquidSize = true;
    }
}
