/*
class A:

	class B:

		[attr]
		public interface C:
			pass

	[attr]
	internal interface D:
		pass
*/

class A {
	
	class B {
		@attr
		public interface C {}
	}
	
	@attr
	internal interface D {
	}
}