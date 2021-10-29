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
    //sound
    [SerializeField] private AudioSource audioSource;

    //after finish experinment
    [SerializeField] private GameObject lastInstruction,instruction7,endGame;
    public RectTransform rt;

    //hide all buttons after the end of experiment Button
    [SerializeField] private GameObject waterButton,vinegarButton,colorButton,soabButton,bakingSodaButton,progressBar;
    [SerializeField] private float timeToInvokeInstrucation;

    //display lava of volcano
    [SerializeField] private GameObject lava;

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
            Invoke("finished",timeToInvokeInstrucation);
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
        enableSound();
        Instantiate(explosionEffect, transform.position, transform.rotation);

       // Destroy(explosionEffect);
        Debug.Log("\nafter destroy explosion ");

        lava.SetActive(true);
    }

    void finished(){
        instruction7.SetActive(false);
        lastInstruction.SetActive(true);

        //diable all buttons
        waterButton.SetActive(false);
        vinegarButton.SetActive(false);
        colorButton.SetActive(false);
        soabButton.SetActive(false);
        bakingSodaButton.SetActive(false);
        progressBar.SetActive(false);

        //button to end game
        endGame.SetActive(true);
    }

    void enableSound(){
        audioSource.Play();
        Debug.Log("\n\t\t*****ExplosionSoundt*****\t\t\n");  
    }
}
