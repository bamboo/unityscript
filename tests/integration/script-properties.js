/*
42
-1
*/
private var _v = 42;

function get v() {
	return _v;
}

function set v(value) {
	_v = value;
}

print(v);
v = -1;
print(v);
