/*
1
0
*/
import UnityScript.Lang;

function purge() {
	for (var i=0; i<3; ++i) System.GC.Collect();
}

function main() {
	
	purge();

	var o = new Object();
	o.LifeTheUniverseAndEverything = 42;
	
	print(ExpandoServices.ExpandoObjectCount);
	
	o = null; 
	
	// expando support shouldn't keep
	// objects from being garbage collected	
	purge();
	
	print(ExpandoServices.ExpandoObjectCount);
}

main();
