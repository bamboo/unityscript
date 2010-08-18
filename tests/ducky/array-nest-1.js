/*
0
*/
var homeBase = new Array(); 

class HomeBaseVars 
{ 
	var avatar              : Array; 
} 

homeBase[0] = new HomeBaseVars ();
homeBase[0].avatar = new Array();

// System.MissingMethodException : Cannot find the requested method.
homeBase[0].avatar.push(0); 
print(homeBase[0].avatar[0]);