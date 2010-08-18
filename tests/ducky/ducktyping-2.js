/*
1
System.Int32
*/
// Somehow test becomes a duck typed value (Happens only with private variables)
private var test = 0;

test++;
print(test);
print(test.GetType().ToString());