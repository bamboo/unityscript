/*
fn = { i | i * 2 }

doubledEven = (1, 2, 3).Where({ i | (i % 2) == 0 }).Select({ i | i * 2 })

foo({ i, j | i * j }, { i, j | i < j })
*/
var fn = function(i) i*2;
var doubledEven = [1, 2, 3].Where(function(i) i%2 == 0).Select(function(i) i*2);
foo(function(i, j) i*j, function(i, j) i < j);

