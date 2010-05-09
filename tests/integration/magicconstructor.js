/*
2
*/

var p = 0;


/// This is not actually a constructor. Because no class was ever defined.
/// Thus this is just a normal function.
function magicconstructor (value : int) : int
{
	p = value;
	return 2;
}

var value = magicconstructor(1);
print(value);