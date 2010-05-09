namespace UnityScript.Tests.CSharp
{
	public class ConstructorTest
	{
		public ConstructorTest (params int[] values)
		{
			foreach (int i in values)
				System.Console.WriteLine(i);
		}
	}
}
