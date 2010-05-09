/*
Original
Assignment
*/
// When the variable name in the class is the same as the 
// variable name of the iterator, the iterator will be assigned the value

class ContainerClass
{
	var target : String = "ContainerUnchanged";
}

var objects = ["Original"];
var testB : ContainerClass = new ContainerClass();
for (var target in objects)
{
	testB.target = "Assignment";
	
	print(target);
	print(testB.target);
}