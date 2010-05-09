/*
1
1
*/
// Particle is a struct which a property position. Position is another struct
// with 3 member fields, x, y, z.

// static typing with foreach
var test = new UnityScript.Tests.CSharp.Particle[10];
for (var a in test)
	a.position.y += 1;
print(test[0].position.y);

// static typing with indexing
var test_2 = new UnityScript.Tests.CSharp.Particle[10];
for (var b=0;b<test_2.Length;b++)
	test_2[b].position.y += 1;
print(test_2[0].position.y);
