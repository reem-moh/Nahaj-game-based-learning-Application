using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Reset : MonoBehaviour {

	// Use this for initialization
    
	public void ResetScene()
    {
        //pretty complex, might need to make a powerpoint slide...
        SceneManager.LoadScene(0);
    }
}
