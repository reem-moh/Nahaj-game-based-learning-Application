using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;


public class ARTapToPlaceObject : MonoBehaviour
{
//public GameObject placementIndicator;
public GameObject gameObjToActivate;


private ARRaycastManager arRaycastManager;
private GameObject spawnedObj;
private Vector2 touchPosition;

static List<ARRaycastHit> hits = new List<ARRaycastHit>();

[SerializeField] private GameObject clickOnScrean,firstInstruction,arrow;
[SerializeField] private float timeToInvokeInstrucation;
//private Pose placementPose;
//private bool placementPoseIsValid = false;

// Start is called before the first frame update
/*void Start()
{
arRaycastManager = FindObjectOfType<ARRaycastManager>();
}*/
private void Awake() {
    arRaycastManager = GetComponent<ARRaycastManager>();
}

bool TryGetTouchPosition(out Vector2 touchPosition){
    if (Input.touchCount > 0){
        touchPosition = Input.GetTouch(0).position;
        return true;
    }
    touchPosition = default;
    return false;
}

// Update is called once per frame
void Update()
{

if(!TryGetTouchPosition(out Vector2 touchPosition))
return;

if(arRaycastManager.Raycast(touchPosition,hits,TrackableType.Planes)){
    var hitPose = hits[0].pose;

    if(spawnedObj.active == false){
        spawnedObj.SetActive(true);
        spawnedObj.transform.position = hitPose.position;
        Destroy(clickOnScrean);
        Invoke("showInstruction",timeToInvokeInstrucation);
    }
}
//UpdatePlacementPose();
//UpdatePlacementIndicator();
}

void showInstruction(){

        firstInstruction.SetActive(true);
        arrow.SetActive(true);
    }

/*private void UpdatePlacementPose()
{
var screenCenter = Camera.current.ViewportToScreenPoint(new Vector3(0.5f,0.5f));
var hits = new List<ARRaycastHit>();
arRaycastManager.Raycast(screenCenter, hits, TrackableType.Planes);

placementPoseIsValid = hits.Count > 0;
if(placementPoseIsValid)
{
placementPose = hits[0].pose;
}
}

private void UpdatePlacementIndicator()
{
if(placementPoseIsValid)
{
placementIndicator.SetActive(true);
placementIndicator.transform.SetPositionAndRotation(placementPose.position, placementPose.rotation);
}
else
{
placementIndicator.SetActive(false);
}
}*/
}