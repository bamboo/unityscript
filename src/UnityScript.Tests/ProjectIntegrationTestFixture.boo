namespace UnityScript.Tests

import NUnit.Framework
import Boo.Lang.Compiler.IO
import System.IO

[TestFixture]
partial class ProjectIntegrationTestFixture(AbstractIntegrationTestFixture):
	
	override def CompileTestCase(location as string):
		return CompileTestCase(*array(FileInput(file) for file in SourceFilesIn(location)))
		
	override def GetExpectedOutput(location as string):
		return super(SourceFilesIn(location)[0])
		
	def SourceFilesIn(location as string):
		files = Directory.GetFiles(location, "*.js")
		System.Array.Sort(files)
		return files
	