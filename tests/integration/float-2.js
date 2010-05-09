/*
System.Single
*/

Test ();
function Test ()
{
	// The error goes away if i don't use var
	var value = .5;
	System.Console.WriteLine(value.GetType());
}
