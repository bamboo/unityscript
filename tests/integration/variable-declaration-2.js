/*
10
*/

static var p = 50;
static var once = true;

if (once)
{
	once = false;
	
	p = 10;
	
	Awake();
	
	print (p);
}