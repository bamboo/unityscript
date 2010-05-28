namespace UnityScript.Tests

import System
import NUnit.Framework
import Boo.Lang.Useful

[TestFixture]
class UsTestFixture:
			
	[Test]
	def NoWarn():
		argv = (
			"-r:${GetAssemblyLocation()}",
			"-b:UnityScript.Tests.MonoBehaviour",
			"-m:Awake",
			"-nowarn:BCW0016",
			ResolvePath("warnings-1.js"), )
		AssertSuccessfulCompilation(argv)
		
	[Test]
	def ExeTarget():
		argv = (
			"-r:${GetAssemblyLocation()}",
			"-b:UnityScript.Tests.MonoBehaviour",
			"-m:Awake",
			"-target:exe",
			ResolvePath("target-exe.js"), )
		AssertSuccessfulCompilation(argv)
		
	[Test]
	def Pragmas():
		argv = (
			"-r:${GetAssemblyLocation()}",
			"-b:UnityScript.Tests.MonoBehaviour",
			"-m:Awake",
			"-pragmas:strict,implicit",
			ResolvePath("pragmas-1.js"), )
		AssertSuccessfulCompilation(argv)

	[Test]
	def WarningsAndErrorsReportCorrectFileNames():
		argv = (
			"-r:${GetAssemblyLocation()}",
			"-b:UnityScript.Tests.MonoBehaviour",
			"-m:Awake",
			ResolvePath("errors-1.js"), )
		AssertErrorMessageAndExitCode(argv)
	
	[Test]
	def AcceptsMultipleReferences():
		argv = (
			"-r:${GetAssemblyLocation()}",
			"-r:${GetAssemblyLocation()}",
			"-b:UnityScript.Tests.MonoBehaviour",
			"-m:Awake",
			ResolvePath("errors-1.js"), )
		AssertErrorMessageAndExitCode(argv)
		
	def ResolvePath(fname as string):
		return "${AbstractCompilerTestFixture.BasePath}/tests/us/${fname}" 
		
	def AssertErrorMessageAndExitCode(argv as (string)):
		exitCode, output as string = ExecuteUs(argv)
		expected = """
		${ResolvePath('errors-1.js')}(2,4): BCE0005: Unknown identifier: 'undefinedNoPathNameError'.
		"""
		Assert.AreEqual(255, exitCode)
		Assert.AreEqual(expected.Trim(), output.Trim())
		
	def AssertSuccessfulCompilation(argv as (string)):
		exitCode, output as string = ExecuteUs(argv)
		Assert.AreEqual(0, exitCode, output)
		assert output.Trim().StartsWith("Successfully compiled")
		
	def ExecuteUs(argv as (string)):
		if PlatformInformation.IsMono:
			p = shellp("mono", UsExePath + " ${join(argv)}")
		else:
			p = shellp(UsExePath, join(argv))
			
		output = p.StandardOutput.ReadToEnd()
		p.WaitForExit()
		return p.ExitCode, output
		
	static def shellp(filename as string, arguments as string):
		p = System.Diagnostics.Process()
		p.StartInfo.Arguments = arguments
		p.StartInfo.CreateNoWindow = true
		p.StartInfo.UseShellExecute = false
		p.StartInfo.RedirectStandardOutput = true
		p.StartInfo.RedirectStandardInput = true
		p.StartInfo.RedirectStandardError = true
		p.StartInfo.FileName = filename
		p.Start()
		return p

	UsExePath:
		get: return typeof(us.CommandLineOptions).Module.FullyQualifiedName
		
