/*
[SomeAttribute]
[SomeOtherAttribute(true, false)]
class Foo:

	[AnotherOne(true, Name: 'foo')]
	def bar():
		pass

	[AttributeForField(Foo.Bar)]
	field as String
*/
@SomeAttribute
@SomeOtherAttribute(true, false)
class Foo {

	@AnotherOne(true, Name="foo")
	function bar() {
	}
	
	@AttributeForField(Foo.Bar)
	var field:String;
}