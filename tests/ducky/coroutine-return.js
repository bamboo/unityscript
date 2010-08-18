/*
test
*/
var shipType =  "test"; 

Test();

function GetShipType() { 
	return shipType;
} 

function Test() { 
	var myParent;
	myParent = this;
	var tname = myParent.GetShipType();
	print(tname); 
}