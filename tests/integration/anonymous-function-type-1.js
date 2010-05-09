/*
1
2
3
*/
function foreach(items, action: function(Object): void) {
	for (var item in items) action(item);
}

foreach([1, 2, 3], function(i) { print(i); }); 
