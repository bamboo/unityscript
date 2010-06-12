namespace UnityScript.Tests

import System.IO
import NUnit.Framework

[TestFixture]
class CommandLineOptionsTestFixture:

	[Test]
	def Defines():
		options = us.CommandLineOptions("-d:FOO", "--define:BAR")
		assert options.Defines == ["FOO", "BAR"]
	
			
	[Test]
	def SourceDirectoriesAreRecursivelyScanned():
		dir = CreateTempDirectory()
		
		files = "a.js", "Sub1/b.js", "Sub1/c.js", "Sub1/Sub2/d.js", "Sub1/Sub2/Sub3/Sub4/e.js"
		CreateFilesOn(dir, files)
		
		options = us.CommandLineOptions("-srcdir:${dir}")
		
		actualFiles = List of string()
		options.ForEachSourceFile(actualFiles.Add)
		
		Assert.AreEqual(
			array(Path.Combine(dir, file) for file in files),
			actualFiles.ToArray())
			
def CreateFilesOn(dir as string, files as string*):
	for file in files:
		fullName = Path.Combine(dir, file)
		Directory.CreateDirectory(Path.GetDirectoryName(fullName))
		File.WriteAllText(fullName, "")
	
def CreateTempDirectory():
	tmp = Path.GetTempFileName()
	File.Delete(tmp)
	Directory.CreateDirectory(tmp)
	return tmp
