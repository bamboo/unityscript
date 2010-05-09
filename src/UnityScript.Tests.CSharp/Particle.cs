namespace UnityScript.Tests.CSharp {
	public struct Particle {
		Vector3 _position;
		public Vector3 position {
			get { return _position; }
			set { _position = value; }
		}
	}
}
