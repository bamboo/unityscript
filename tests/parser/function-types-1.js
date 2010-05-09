/*
f as callable(int) as int = { i | return (i * 2) }

def time(block as callable()):
	pass
*/
var f:function(int):int = function(i) { return i*2; };
function time(block: function()) {}
