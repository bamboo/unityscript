/*
strict-disallows-implicit-variable-declaration.js(9,5): BCE0005: Unknown identifier: 'test1'.
strict-disallows-implicit-variable-declaration.js(10,11): BCE0005: Unknown identifier: 'test1'.
*/
#pragma strict

function Start()
{
    test1 = true;
    print(test1);
}