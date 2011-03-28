/*
foo
bar
*/
import System.Collections.Generic;

var dict : Dictionary.<String,function()>;
dict = new Dictionary.<String,function()>();
dict["foo"] = function() print("foo");
dict["bar"] = function() print("bar");

dict["foo"]();
dict["bar"]();
