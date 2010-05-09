/*
1
1
*/
// Particle is a struct which a property position. Position is another struct
// with 3 member fields, x, y, z.

// dynamic typing with foreach
var test_2;
test_2 = new UnityScript.Tests.CSharp.Particle[10];
for (var b in test_2)
	b.position.y += 1;

print(test_2[0].position.y);


// dynamic typing with indexing
var test_4;
test_4 = new UnityScript.Tests.CSharp.Particle[10];
for (var d=0;d<test_4.length;d++)
	test_4[d].position.y += 1;

print(test_4[0].position.y);
