/*
try:
	raise System.ApplicationException('testing...')
ensure:
	print('yes...')
*/
try {
	throw new System.ApplicationException("testing...");
} finally {
	print("yes...");
}
