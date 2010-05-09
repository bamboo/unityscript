/*
Hello
*/

class otherclass
{
	var p = "";
	
	function otherclass (value : String, value_ : String)
	{
		p = value;
	}
}

var m = new otherclass("Hello", "Unused");
print(m.p);