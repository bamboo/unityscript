/*
0.04210299
*/
#pragma strict

function randomNumber2D(x: float, y: float): float {
	var a: ulong = x * System.Convert.ToSingle(uint.MaxValue);
	var b: ulong = y * System.Convert.ToSingle(uint.MaxValue);
	
	//hash numbers
	var key : ulong = (a << 32) | b;
	key = (~key) + (key << 18);
	key = (key & ~(key >> 31)) | (~key & (key >> 31));
	key = (key + (key << 2)) + (key << 4); //key = key * 21;
	key = (key & ~(key >> 11)) | (~key & (key >> 11));
	key = key + (key << 6);
	key = (key & ~(key >> 22)) | (~key & (key >> 22));
	
	//discard 32 most significant bits and scale to between 0 and 1
	return (key & 0xFFFFFFFF) / System.Convert.ToSingle(uint.MaxValue);
}

print(randomNumber2D(.9996847, .4148785));
