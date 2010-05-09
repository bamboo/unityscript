namespace UnityScript.Tests.CSharp {
	public struct Vector3 {
		public int x;
		public int y;
		public int z;
		
		public int yProperty { get { return y; } set { y = value; } }
		
		public Vector3(int x, int y, int z) {
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public int this [int index]
		{
			get
			{
				switch(index)
				{
					case 0: return x;
					case 1: return y;
					default:
					throw new System.IndexOutOfRangeException("Invalid Vector2 index!");
				}
			}
	
			set
			{
				switch(index)
				{
					case 0: x = value; break;
					case 1: y = value; break;
					default:
					throw new System.IndexOutOfRangeException("Invalid Vector2 index!");
				}
			}
		}



	}

	public class SomeComponent
	{
		TransformCS _trans = new TransformCS();
	
		public TransformCS transform { get { return _trans; } }
	}

	public class StaticTest
	{
		TransformCS _trans = new TransformCS();
	
		public static void PrintSomething (string p) { System.Console.WriteLine(p); }
	}
	
	public class TransformCS
	{
		Vector3 _pos;
		
		string[] _stringArray = new string[1];
		
		public Vector3 position { get { return _pos; } set { _pos = value; } }
		
		public string[] stringArray { get { return _stringArray; } }
	}
}
