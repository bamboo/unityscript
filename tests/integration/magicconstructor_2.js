/*
Hello
*/

class magicconstructor_2
{
	var p = "";
	
	function magicconstructor_2 (value : String, value2 : String)
	{
		p = value;
	}

	function magicconstructor_2 ()
	{
	}
}

static var once = true;

if (once)
{
	once =  false;
	var m = new magicconstructor_2("Hello", "Unused");
	print(m.p);
}