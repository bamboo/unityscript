/*
try:
	raise System.ApplicationException('testing...')
except x as System.ApplicationException:
	print(x.Message)
except x as System.Exception:
	print('uops...')
ensure:
	print('yes...')
*/
try {
	throw new System.ApplicationException("testing...");
}
catch (x:System.ApplicationException) {
	print(x.Message);
}
catch (x) {
	print("uops...");
}
finally {
	print("yes...");
}
