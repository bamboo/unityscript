/*
1
*/

static function MyFunction( f : int ) : int
{
	return f + 1;
}

/* on windows this throws OverflowException */
var f = MyFunction( -0.001 );
print(f);
