namespace UnityScript.Tests

import System.IO
import Boo.Lang.Compiler
import Boo.Lang.Compiler.IO
import NUnit.Framework from nunit.framework

abstract class AbstractCompilerTestFixture(AbstractCompilerTest):
	
	virtual DisplayErrorStackTrace:
		get: return false
	
	static BasePath as string:
		get: return _basePath or _basePath = FindTestsPath()
	
	private static _basePath as string

	virtual def CompileTestCase([required] fname as string):
		return CompileTestCase(FileInput(fname))
	
	def RunTestCase(fname as string):
		location = ResolvePath(fname)
		result = CompileTestCase(location)
		CheckTestCaseCompilationResult(result)
		CheckTestCaseOutput(location, GetActualOutput(result))
		
	virtual protected def CheckTestCaseCompilationResult([required] result as CompilerContext):
		Assert.AreEqual(0, result.Errors.Count, result.Errors.ToString(DisplayErrorStackTrace))
		
	def CheckTestCaseOutput([required] fname as string, [required] output as string):
		VerifyOutput(NormalizeWhiteSpace(GetExpectedOutput(fname)), NormalizeWhiteSpace(output))
		
	protected virtual def VerifyOutput(expected as string, actual as string):
		Assert.AreEqual(expected, actual)
		
	def ResolvePath(fname as string):		
		return Path.Combine(BasePath, fname)
		
	static def FindTestsPath():
		path = Path.GetFullPath("..")
		while not Directory.Exists(Path.Combine(path, "tests")):
			oldPath = path
			path = Path.GetDirectoryName(path)
			raise "'tests' directory not found" if oldPath == path
		return path
	
	def NormalizeWhiteSpace(code as string):
		return code.Trim().Replace("\r\n", "\n")
		
	protected virtual def GetActualOutput(result as CompilerContext) as string:
		return result.CompileUnit.Modules[0].ToCodeString()
	
	protected virtual def GetExpectedOutput([required] fname as string):
		contents = ReadAllText(fname)
		start = contents.IndexOf("/*")
		end = contents.IndexOf("*/", start + 2)
		Assert.IsTrue(start >= 0 and end > start, "Test case file is not in the correct format: ${fname}")
		return contents[start+2:end].Trim()
		
def ReadAllText(fname as string):
	using reader=File.OpenText(fname):
		return reader.ReadToEnd()
