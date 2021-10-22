using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class explosion : MonoBehaviour
{
    //time before explosion
    public float delay;
    //for counting the time before explosion
    float countdown;
    //check if explosion or not
    bool hasExploded;
    //change it after the last step is end
    bool lastStep;

    //for show effect
    public GameObject explosionEffect;

    void Start()
    {
        countdown = delay;
        hasExploded = false;
        lastStep = false;
    }

    // Update is called once per frame
    void Update()
    {
        countdown -= Time.deltaTime;

        if(countdown <= 0.0f && !hasExploded && lastStep){
            explode();
            hasExploded = true;
        }
    }

    void OnCollisionEnter(Collision other){
        Debug.Log("\nOnCollisionEnter last step Explode");
        if (other.gameObject.CompareTag("bottle"))
        {
            countdown = delay;
            lastStep = true;
        }
    }

    void explode(){
        Instantiate(explosionEffect, transform.position, transform.rotation);

       // Destroy(explosionEffect);
        Debug.Log("\nafter destroy explosion ");
    }
}
