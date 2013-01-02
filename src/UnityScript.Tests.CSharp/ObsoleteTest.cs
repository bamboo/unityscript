namespace UnityScript.Tests.CSharp 
{
	public class ObsoleteTest 
	{
		
		[System.Obsolete ("My Warning Text!")]
		public void ObsoleteMethod ()
		{
		
		}

		[System.Obsolete ("My Warning Text!")]
		public static void ObsoleteStaticMethod ()
		{
					
		}

		[System.Obsolete ("My Warning Text!")]
		public int ObsoleteProperty
		{
			get { return 0; }
		}

		[System.Obsolete ("My Warning Text!")]
		public static int ObsoleteStaticProperty
		{
			get { return 0; }
		}





		[System.Obsolete ("My Warning Text!", true)]
		public void ObsoleteErrorMethod ()
		{
		
		}

		[System.Obsolete ("My Warning Text!", true)]
		public static void ObsoleteErrorStaticMethod ()
		{
					
		}

		[System.Obsolete ("My Warning Text!", true)]
		public static int ObsoleteErrorStaticProperty
		{
			get { return 0; }
		}

		[System.Obsolete ("My Warning Text!", true)]
		public int ObsoleteErrorProperty
		{
			get { return 0; }
		}
	}
}
