using Boo.Lang;

namespace UnityScript.Tests.CSharp 
{
	// This class always returns false on implicit operator bool
	// And all operator == will return true.
	public class OperatorOverloadTest 
	{
		public override bool Equals(object o)
		{
			return true;
		} 

		public override int GetHashCode()
		{
			return 0;
		}

		public static implicit operator bool (OperatorOverloadTest exists)
		{
			return false;
		}
	
		public static bool operator == (OperatorOverloadTest x, OperatorOverloadTest y)
		{ 
			return true; 
		}

		public static bool operator != (OperatorOverloadTest x, OperatorOverloadTest y)
		{ 
			return false;
		} 
	}

	public class DerivedOperatorOverloadTest : OperatorOverloadTest
	{
		[DuckTyped]
		public static OperatorOverloadTest GetDerivedOperatorUntyped ()
		{
			return new DerivedOperatorOverloadTest ();
		}		
	}
}
