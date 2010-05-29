/*
Bar.Run
Bar.Run
*/
class Foo {
	public function Run(): void {
	}
}

class Bar extends Foo {
	public override function Run(): void {
		System.Console.WriteLine("Bar.Run");
	}
}

var foos:Foo[] = [new Bar(), new Bar()];
for (var foo:Bar in foos) {
	foo.Run();
}
