/*
42
*/

var a = 3;
eval( "class Foo { "
	+ "	public function Run() { "
	+ "		a = 42;"
	+ "	} "
	+ "}; "
	+ "new Foo().Run();");
	
print(a);

