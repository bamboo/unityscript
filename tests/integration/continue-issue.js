/*
2
*/

Do ();

function Do ()
{
	var pixelArray : int[] = [0, 1, 2, 3, 4];
	
	for( var i = 0; i < pixelArray.Length; ++i )
	{
		if (i == 0)
			continue;

		if (i == 1)
			continue;

		// Break seems to work correctly
		// (The issue is caused by the two continue statements)		
		if (i == 3)
			break;
		
		print(pixelArray[i]);
	}
}