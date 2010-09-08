/*
1
3
*/
import System.Linq.Enumerable;

var a = [1, 2, 3];
var oddNumbers = a.Where(function(i) { return i % 2 != 0; });
for (var i in oddNumbers) print(i);

