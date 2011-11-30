/*
match foo:
	when bar:
		return 42
	when baz | gazonk:
		return (-1)
	otherwise :
		return null
unchecked
*/
match foo {
	when bar {
		return 42;
	}
	when baz | gazonk { 
		return -1;
	}
	otherwise {
		return null;
	}
}

unchecked {
	
}

