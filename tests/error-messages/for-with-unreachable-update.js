/*
for-with-unreachable-update.js(5,32): BCW0015: WARNING: Unreachable code detected.
*/
function Positive(n: int): boolean {
	for (var i = 0; i < n; ++i) { // ++i is unreachable
		return true;
	}
	return false;
}
