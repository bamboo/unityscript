/*
invalid-generator-return-type.js(4,17): BCE0101: Return type 'String[]' cannot be used on a generator. Did you mean 'IEnumerator'? You can also use 'System.Collections.IEnumerable' or 'object'.
*/
function foo(): String[] {
	yield "foo";
}

foo();
