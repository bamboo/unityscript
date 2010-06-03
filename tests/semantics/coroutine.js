/*
import UnityScript.Tests

partial class coroutine(UnityScript.Tests.MonoBehaviour):

	private def spam():
		yield 
		yield 0
		yield 1
		yield 2

	public virtual def Awake():
		enumerate = spam()
		for e in enumerate:
			print(e)
*/

private function spam()
{
	// Allow for this shorthand form of yield.
	// It should yield 0
	yield;
	yield 0;
	yield 1;
	yield 2;
}

enumerate = spam();
for (var e in enumerate)
{
	print(e);
}
