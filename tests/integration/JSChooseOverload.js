/*
using float
0.5
*/

static function MyClamp( f : float, min : float, max : float ) : float
{
	print("using float");
	if( f < min )
		f = min;
	if( f > max )
		f = max;
	return f;
}

static function MyClamp( f : int, min : int, max : int ) : int
{
	print("using int");
	if( f < min )
		f = min;
	if( f > max )
		f = max;
	return f;
}

/* should choose all float version like C# does */
var f = MyClamp( 0.5, -10, 10 );
print(f);
