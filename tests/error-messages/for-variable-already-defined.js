/*
for-variable-already-defined.js(11,18): BCE0067: There is already a local variable with the name 's'.
*/
function Start()
{	
	var ss = new String[1];
	var s = "";
	
	for (s in ss) { print(s); } // reuse the variable
	
	for (var s in ss) { print(s); } // declaring a new one, disallow
}
