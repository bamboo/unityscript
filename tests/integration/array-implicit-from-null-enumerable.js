/*
null enumerable becomes null array
*/
function doIt() {
	var nativeArray: System.Collections.IEnumerable = null;
	var array: Array = nativeArray;
	if (array == null) print("null enumerable becomes null array");
}

doIt();

