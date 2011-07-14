/*
import UnityScript.Tests

partial public class magic-members(UnityScript.Tests.MonoBehaviour):

	public value as int

	public virtual def Awake() as void:
		if 1:
			otherValue1 = 7
		else:
			otherValue2 = 7
		while 0:
			otherValue3 = 7

	public def constructor():
		super()
		self.value = 5
*/
// When a variable declaration is inside of a block it shouldnt become a member variable

var value = 5;

if (1)
{
	var otherValue1 = 7;
}
else
	var otherValue2 = 7;
	
while (0)
{
	var otherValue3 = 7;
}
