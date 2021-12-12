using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class AnimalExpInstructions : MonoBehaviour
{
    [SerializeField] private GameObject instruction1;
    // Start is called before the first frame update
    void Start()
    {
        gameObject.GetComponent<Button>().onClick.AddListener(ShowInstruction);
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void ShowInstruction(){
        instruction1.SetActive(false);
    }
}
