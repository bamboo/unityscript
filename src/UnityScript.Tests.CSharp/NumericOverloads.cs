using System;

namespace UnityScript.Tests.CSharp
{
	public static class NumericOverloads
	{
		public static void F(float x, float y)
		{
			Console.WriteLine("F(float, float)");
		}
		
		public static void F(int x, int y)
		{
			Console.WriteLine("F(int, int)");
		}
	}
}

