using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LiquidPool : MonoBehaviour {

	// Use this for initialization
    public float minSize = 0.5f;
    public float maxSize = 1.0f;
    public float timeToComplete = 0.5f;
    float randomSize;
    float currentTime = 0.0f;
    bool fadingOut = false;
    MeshRenderer mr;
    Material mat;
	void Start () {

        transform.localScale = Vector3.zero;
        randomSize = Random.Range(minSize, maxSize);
        mr = GetComponent<MeshRenderer>();
        mat = mr.material;
        mat = Instantiate(mat);
        mr.material = mat;
	}
	
	// Update is called once per frame
	void Update () {
        currentTime += Time.deltaTime * ((fadingOut) ? -1 : 1);
        if (currentTime >= timeToComplete)
        {
            fadingOut = true;
        }
        if(fadingOut)
        {
            mat.color = new Color(mat.color.r,mat.color.g,mat.color.b,Mathf.Lerp(0.0f, 1.0f, currentTime/timeToComplete));
        }
        else
        {
            transform.localScale = Vector3.one * Mathf.Lerp(0.0f, randomSize, currentTime / timeToComplete);
        }
        if(fadingOut)
        {
            if(currentTime <= 0)
            {
                Destroy(transform.gameObject);
            }
        }
	}
}
