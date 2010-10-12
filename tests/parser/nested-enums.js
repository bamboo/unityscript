/*
class Container:

	enum E1:

		Foo

		Bar

	public enum E2:

		Foo

		Bar

	[flags]
	enum E3:

		Foo = 1

		Bar = 2
*/
class Container {
	enum E1 { Foo, Bar }
	public enum E2 { Foo, Bar }
	
	@flags
	enum E3 {
		Foo = 1,
		Bar = 2
	}

}

