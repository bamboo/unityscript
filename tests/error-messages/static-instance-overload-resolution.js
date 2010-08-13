/*
*/
var startInfo = new System.Diagnostics.ProcessStartInfo();

function Start() {
	var process = System.Diagnostics.Process.Start(startInfo);
	process.WaitForExit(); // just to use the variable
}

