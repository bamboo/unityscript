/*
true
true
true
*/
var duck;
duck = new UnityScript.Tests.CSharp.OperatorBoolTest ();
duck.isValid = true;

if (duck)
	print("true");
if (!duck)
	print("false");

duck.isValid = false;
if (!duck)
	print("true");
if (duck)
	print("false");
	
duck = null;
if (duck)
	print("false");
if (!duck)
	print("true");
