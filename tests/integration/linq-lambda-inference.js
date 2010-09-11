/*
1
3
1
3
*/
import System.Linq.Enumerable;

function foreach(items, action: function(Object)) {
	for (var item in items) action(item);
}

var odd = [1, 2, 3].Where(function(i) i % 2 != 0);
var p = function(o) print(o);
foreach(odd, p);
foreach(odd, function(o) print(o));

