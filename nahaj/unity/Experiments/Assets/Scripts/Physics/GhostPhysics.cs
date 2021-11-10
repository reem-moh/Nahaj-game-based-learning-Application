using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GhostPhysics : MonoBehaviour {

    // Use this for initialization
    private BottleSmash _smash;
    private Transform _ghost;

    public GameObject _ghostObject;
    public bool _redirectSelection = false;

    [Header("Reference")]
    public Transform _externalTransform;

	void Start () {
        _smash = GetComponent<BottleSmash>();
        _ghost = Instantiate(_ghostObject).transform;
        _ghost.position = transform.position;
        _ghost.rotation = transform.rotation;
        _ghost.localScale = _smash.Glass.transform.localScale;
        _externalTransform = _ghost;
        MeshCollider mc = _ghost.gameObject.GetComponent<MeshCollider>();
        mc.sharedMesh = _smash.Glass.GetComponent<MeshFilter>().sharedMesh;

        _ghost.GetComponent<ConveyImpacts>()._physics = this;

	}

    private void OnDestroy()
    {
        if (_ghost != null)
        {
            Destroy(_ghost.gameObject);
        }
    }

    public void SendCollision(Collision col)
    {
        if (_smash != null)
        {
            _smash.AttemptCollision(col);
        }
    }

    public Transform GetController()
    {

        return _ghost;

    }

    // Update is called once per frame
    void Update () {
		if(_ghost != null)
        {
            transform.position = _ghost.position;
            transform.rotation = _ghost.rotation;
        }
#if UNITY_EDITOR
        if(_redirectSelection)
        {
            if(UnityEditor.Selection.activeTransform == this.transform)
            {
                UnityEditor.Selection.activeTransform = _ghost;
            }
        }
#endif
    }
}
