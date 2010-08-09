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
	}
}
