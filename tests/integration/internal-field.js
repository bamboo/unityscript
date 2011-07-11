/*
True
*/
import System.Reflection;

internal var i = 42;

print(GetType().GetField("i", BindingFlags.Instance|BindingFlags.NonPublic).IsAssembly);
