/*
10
*/

/*
var p = 50;

When i execute the main function of this single line script. It seems like p = 50 is executed.
This should not happen, the value should only be initialized in the constructor.

*/



var p = 50;
static var once = true;

if (once)
{
	once = false;
	
	p = 10;
	
	Awake();
	
	print (p);
}