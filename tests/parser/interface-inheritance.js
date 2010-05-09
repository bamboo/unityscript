/*
interface I(J):
	pass

interface H(I, J):
	pass
*/
interface I extends J {
}

interface H extends I, J {
}
