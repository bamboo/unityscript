/*
before
yeah!
after
*/
function around(action: function()) {
	print("before");
	action();
	print("after");
}

around(function() { print("yeah!"); }); 
