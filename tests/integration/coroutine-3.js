/*
0
Hello World
*/

private var counter : int = 1;

for (var e in GetClick ())
{
	print(e);
}

function GetClick ()
{
	yield 0;
	if (--counter == 0)
		print("Hello World");
}