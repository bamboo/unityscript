/*
CHOCO
42
*/
import UnityScript.Tests;

var ray = new Ray();
var t : float;

function Update () {
	if(transform.collider.bounds.IntersectRay(ray, t)){
		print("CHOCO");
		print(t);
	}
}

Update();
