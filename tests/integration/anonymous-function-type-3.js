/*
1
2
*/
function loopWhile(items, action: function(Object): boolean) {
	for (var item in items) if (!action(item)) break;
}

function main() {
	var stop = 2;
	loopWhile([1, 2, 3], function(i: int) {
		print(i);
		return i < stop;
	});
}

main();
