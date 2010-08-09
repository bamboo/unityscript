/*
caught
recaught
*/
function rethrow() {
	try {
		throw new System.ApplicationException();
	} catch (e) {
		print("caught");
		throw;
	}
}

try {
	rethrow();
} catch (e:System.ApplicationException) {
	print("recaught");
}
