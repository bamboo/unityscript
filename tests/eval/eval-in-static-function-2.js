/*
script(1,7): BCE0020: An instance of type 'eval-in-static-function-2' is required to access non static member 'a'.
script(1,11): BCE0020: An instance of type 'eval-in-static-function-2' is required to access non static member 'bar'.
*/
import UnityScript.Scripting;

static function tryEvalWithInstanceMembers() {
	eval("print(a); bar();");
}

function bar() {
	// instance function
}

var a = 42; // instance field
try {
	tryEvalWithInstanceMembers();
} catch (x : CompilationErrorsException) {
	print(x.Errors.ToString());
}
	
	
