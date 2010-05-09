/*
public
*/

class variables extends UnityScript.Tests.MonoBehaviour
{
	var a = "foo";
}

var field = GetType().GetField("a");
if (field == null)
	print ("a null");
else if (field.IsPublic)
	print ("public");
