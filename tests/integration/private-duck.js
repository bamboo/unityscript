/*
System.Single
*/
// Making this variable public types it correctly!
private var p = 0.0;

print(this
	.GetType()
		.GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance)
			[0].FieldType);