/*
Right
*/
import UnityScript.Tests;

b = transform as MonoBehaviour;
if (b != null) {
	print ("Wrong");
}
	
c = transform as Transform;
if (c != null) {
	print ("Right");
}