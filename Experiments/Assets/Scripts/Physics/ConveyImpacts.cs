using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConveyImpacts : MonoBehaviour {

    public GhostPhysics _physics;

    void OnCollisionEnter(Collision collision)
    {
        _physics.SendCollision(collision);
    }
}
