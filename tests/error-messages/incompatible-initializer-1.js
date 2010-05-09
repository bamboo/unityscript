/*
incompatible-initializer-1.js(8,43): BCE0022: Cannot convert 'null' to 'float'.
incompatible-initializer-1.js(10,23): BCE0022: Cannot convert 'null' to 'float'.
*/

// When running this script it currently generates a InvalidProgramException
// C# gives a compiler error when assigning null to a float.
private var eventGebeurdeOpTijd : float = null;

eventGebeurdeOpTijd = null;

print(eventGebeurdeOpTijd);