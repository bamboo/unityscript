using System;

namespace UnityScript.Tests.CSharp
{
	public static class VarArgsMethods
	{
		public static int WithVector3(params Vector3[] array)
		{
			return array.Length;
		}
	}
	
	public class VarArgsConstructors
	{
		public readonly Vector3[] array;
		
		public VarArgsConstructors(params Vector3[] array)
		{
			this.array = array;
		}
	}
}

