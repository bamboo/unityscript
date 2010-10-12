/*
enum E1:

	Foo

	Bar

public enum E2:

	Foo

	Bar

[flags]
enum E3:

	[attr]
	Foo = 1

	[attr]
	Bar = 2
*/
enum E1 { Foo, Bar }
public enum E2 { Foo, Bar }

@flags
enum E3 {
	@attr Foo = 1,
	@attr
	Bar = 2
}


