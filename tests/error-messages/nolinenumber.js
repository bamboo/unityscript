/*
nolinenumber.js(14,18): BCE0101: Return type 'void' cannot be used on a generator. Did you mean 'void*'? You can also use 'System.Collections.IEnumerable' or 'object'.
*/

class A
{
	function SpawnBalls()
	{
	}
}

class B extends A
{
	function SpawnBalls()
	{
		yield;
	}
}