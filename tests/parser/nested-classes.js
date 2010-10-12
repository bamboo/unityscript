/*
class A:

	class B:

		[attr]
		public class C:
			pass

	[attr]
	internal class D:
		pass
*/

class A {
	
	class B {
		@attr
		public class C {}
	}
	
	@attr
	internal class D {
	}
}