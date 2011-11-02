/*
5
5
*/
class TStruc extends System.ValueType {
	var blub : int;
}

var oneDim = new TStruc[5];
var multiDim = new TStruc[5,5];
oneDim[0].blub = 5;
print(oneDim[0].blub);

multiDim[0,0].blub = 5;
print(multiDim[0,0].blub);
