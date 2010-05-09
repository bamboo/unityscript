using Boo.Lang;

namespace UnityScript.Tests.CSharp 
{
	// This class always returns false on implicit operator bool
	// And all operator == will return true.
	public class OperatorBoolTest 
	{
		public bool isValid;
		
		public static implicit operator bool (OperatorBoolTest test)
		{
			return test.isValid;
		}
	}
	
	public class OperatorBoolProperties
	{
		[Boo.Lang.DuckTyped]
		public static OperatorBoolTest boolOperatorTestFalse 
		{
			get {
				OperatorBoolTest test = new OperatorBoolTest();
				test.isValid = false;
				return test;
			}
		}

		[Boo.Lang.DuckTyped]
		public static OperatorBoolTest boolOperatorTestFalseInstance 
		{
			get {
				OperatorBoolTest test = new OperatorBoolTest();
				test.isValid = false;
				return test;
			}
		}

		[Boo.Lang.DuckTyped]
		public static OperatorBoolTest GetBoolOperatorTestFalse  ()
		{
			OperatorBoolTest test = new OperatorBoolTest();
			test.isValid = false;
			return test;
		}


		[Boo.Lang.DuckTyped]
		public static OperatorBoolTest GetBoolOperatorTestFalseInstance  ()
		{
			OperatorBoolTest test = new OperatorBoolTest();
			test.isValid = false;
			return test;
		}


	}
}