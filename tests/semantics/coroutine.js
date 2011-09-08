/*
import UnityScript.Tests

partial public class coroutine(UnityScript.Tests.MonoBehaviour):

	private def spam() as System.Collections.IEnumerator:
		return coroutine.$spam$2().GetEnumerator()

	public virtual def Awake() as void:
		enumerate = self.StartCoroutine_Auto(self.spam())
		$iterator$1 = UnityScript.Lang.UnityRuntimeServices.GetEnumerator(enumerate)
		while $iterator$1.MoveNext():
			e = $iterator$1.get_Current()
			Boo.Lang.Builtins.print(e)
			UnityScript.Lang.UnityRuntimeServices.Update($iterator$1, e)

	public def constructor():
		super()

	[System.Runtime.CompilerServices.CompilerGeneratedAttribute]
	internal final class $spam$2(Boo.Lang.GenericGenerator[of int]):

		public virtual def GetEnumerator() as System.Collections.Generic.IEnumerator[of int]:
			return coroutine.$spam$2.$()

		public def constructor():
			super()

		[System.Runtime.CompilerServices.CompilerGeneratedAttribute]
		internal final class $(Boo.Lang.GenericGeneratorEnumerator[of int], System.Collections.IEnumerator):

			public def constructor():
				super()

			public virtual def MoveNext() as boolean:
				__switch__(self._state, $state$0, $state$1, $state$2, $state$3)
				:$state$0
				return self.YieldDefault(2)
				:$state$2
				return self.Yield(3, 42)
				:$state$3
				self.YieldDefault(1)
				:$state$1
				
		
*/

private function spam()
{
	// shorthand form of yield.
	// same as yield 0 in this case
	yield;
	yield 42;
}

enumerate = spam();
for (var e in enumerate)
{
	print(e);
}
