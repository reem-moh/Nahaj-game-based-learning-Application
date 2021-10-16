using UnityEngine;

public class Collider : MonoBehaviour
{
    //edit the animator of the collider object (in this case is water bottle)
    Animator pourLiquid;

    void OnCollisionEnter(Collision other){
        Debug.Log("\nOnCollisionEnterttttttttttttttttt ttttt");
        if (other.gameObject.CompareTag("bottle"))
        {
            Debug.Log("Triggered by bottle");

            //turn off lean scribts to not let user move bottle
             //other.gameObject.GetComponent<LeanDragTranslate> ().enabled = false;

            //change the position of bottle above the volcano
            //other.gameObject.GetComponent<Transform> ().position = new Vector3(-0.074f, 0.38f, -1.7878e-06f);
            
            //change the value of animator to pour liquid
            pourLiquid = other.gameObject.GetComponent<Animator>();
            print(other.gameObject.name);
            pourLiquid.SetTrigger("PourActivate");
        }
        
    }
    
}
