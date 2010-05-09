namespace UnityScript.Tests.CSharp {
	public class TestEnabled {
		public bool _enabled = false;
		public bool enabled { get { return _enabled; } set { _enabled = true; } }
	}
}
