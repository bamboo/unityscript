/*
[SomeAttribute]
[SomeOtherAttribute(true, false)]
class Foo:

	[AnotherOne(true, Name: 'foo')]
	def bar([NotNull] arg1):
		pass

	def baz(arg1, [Required((arg2 > 0))] arg2 as int):
		pass

	[AttributeForField(Foo.Bar)]
	field as String
*/
@SomeAttribute
@SomeOtherAttribute(true, false)
class Foo {

	@AnotherOne(true, Name="foo")
	function bar(@NotNull arg1) {
	}
	
	function baz(arg1, @Required(arg2 > 0) arg2: int) {
	}
	
	@AttributeForField(Foo.Bar)
	var field:String;
}