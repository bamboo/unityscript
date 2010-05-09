/*
System.Collections.IEnumerator
*/
function intCoroutine() {
	yield 21;
}

var returnType = GetType().GetMethod("intCoroutine").ReturnType;
print(returnType.FullName);
