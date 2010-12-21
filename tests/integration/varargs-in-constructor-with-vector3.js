/*
2
1
1
0
0
2
1
0
0
*/
import UnityScript.Tests.CSharp;

class C1 extends VarArgsConstructors {
	function C1() {
		super(Vector3(0, 0, 0), Vector3(0, 0, 0));
	}
}

class C2 extends VarArgsConstructors {
	function C2() {
		super([Vector3(0, 0, 0)]);
	}
}

class C3 extends VarArgsConstructors {
	function C3() {
		super([]);
	}
}

class C4 extends VarArgsConstructors {
	function C4() {
		super();
	}
}


function printArrayLen(o: VarArgsConstructors) {
	print(o.array.Length);
}

var items = [
	VarArgsConstructors(Vector3(0, 0, 0), Vector3(0, 0, 0)),
	VarArgsConstructors([Vector3(0, 0, 0)]),
	VarArgsConstructors(Vector3(0, 0, 0)),
	VarArgsConstructors([]),
	VarArgsConstructors(),
	C1(),
	C2(),
	C3(),
	C4()
];
for (var item in items)
	printArrayLen(item);
