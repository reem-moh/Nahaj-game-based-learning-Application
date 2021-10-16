using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowBottlewater : MonoBehaviour
{
    [SerializeField] private GameObject water;

    private bool waterIsEnabled;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowWater);
        waterIsEnabled = false;
        water.SetActive(waterIsEnabled);
        
    }

    void ShowWater(){
        if(water != null){
         waterIsEnabled ^= true;
         water.SetActive(waterIsEnabled);
        }
        
    }
}
