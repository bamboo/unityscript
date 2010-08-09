using System;

namespace UnityScript.Tests.CSharp
{
	public static class Generics
	{
		public static T Identity<T>(T o)
		{
			return o;
		} 
		
		public static T Instantiate<T>() where T:new()
		{
			return new T();
		}
		
		public static class GenericClass<T>
		{
			public static void GenericMethod<U>(T t, U u)
			{
				Console.WriteLine("GenericMethod({0}, {1})", typeof(T), typeof(U));
			}
		}
	}
}
