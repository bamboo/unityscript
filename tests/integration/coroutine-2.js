/*
0
1
*/
import UnityScript.Tests;

function spam()
{
	yield 0;

	var vec : Vector3;
	vec.x = 1;
	transform.position.x += vec.x;

	print (transform.position.x);
}

for (var e in spam())
{
	print(e);
}
