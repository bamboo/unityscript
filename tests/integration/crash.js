/*
True
True
*/

// I don't know what this should actually successfully compile.
// Could very well be that this should give a compile error.
// the issue is the invalid generated il.


static function Test () : float
{
	return 0.0;	
}

var playerHover = !(Test() || Test());
print (playerHover);
playerHover = !(Test() && Test());
print (playerHover);