/*
Right
*/
import UnityScript.Tests;

var b = transform as MonoBehaviour;
if (b != null) {
	print ("Wrong");
}
	
var c = transform as Transform;
if (c != null) {
	print ("Right");
}