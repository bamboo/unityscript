/*
true
false
FOO
BAR
*/
function test(condition) {
     return condition ? "foo" : "bar";
}

var i = 9;
var j = 5 > i ? "false" : "true";
print(j);

j = "hello" == "hello" ? "false" : "true";
print(j);

print(test(true).ToUpper());
print(test(false).ToUpper());