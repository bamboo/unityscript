/*
bitwise-with-bool-operands-warning.js(8,10): UCW0003: WARNING: Bitwise operation '|' on boolean values won't shortcut. Did you mean '||'?
bitwise-with-bool-operands-warning.js(9,10): UCW0003: WARNING: Bitwise operation '&' on boolean values won't shortcut. Did you mean '&&'?
*/
function b(arg): boolean {
    return true;
}
if (b(1) | b(2)) {}
if (b(1) & b(2)) {}