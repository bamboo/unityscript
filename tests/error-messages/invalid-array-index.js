/*
invalid-array-index.js(11,25): BCE0022: Cannot convert 'UnityScript.Tests.CSharp.Vector3' to 'int'.
*/
import UnityScript.Tests.CSharp;

var tiles : int[,];
var v2 = Vector3(1, 1, 1);

function Start () {
	tiles = new int[5, 5];
	print (tiles[0, v2]);
}

