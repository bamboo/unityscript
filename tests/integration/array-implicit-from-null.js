/*
null native array becomes null array
*/
function doIt() {
	var nativeArray: Object[] = null;
	var array: Array = nativeArray;
	if (array == null) print("null native array becomes null array");
}

doIt();

