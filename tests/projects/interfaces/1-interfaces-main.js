/*
42
*/
class Impl implements Interface {
    function get value() { return 42; }
}

function dump(itf: Interface) { print(itf.value); }

dump(new Impl());
