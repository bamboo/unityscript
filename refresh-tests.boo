#!/usr/bin/env booi
"""
Generates test fixtures from files under tests/
"""
import System
import System.IO
import Boo.Lang.PatternMatching

//def MapPath(path):
//	return Path.Combine(Project.BaseDirectory, path) 

def GetTestCaseName(fname as string):
	return Path.GetFileNameWithoutExtension(fname).Replace("-", "_")
	
def WriteTestCases(writer as TextWriter, baseDir as string):
	count = 0
	for fname in Directory.GetFiles(baseDir):
		continue unless fname.EndsWith(".js")
		++count
		categoryAttribute = CategoryAttributeFor(fname)
		writer.Write("""
	${categoryAttribute}
	[Test] def ${GetTestCaseName(fname)}():
		RunTestCase("${fname.Replace('\\', '/')}")
		""")
	print("${count} test cases found in ${baseDir}.")
	
def CategoryAttributeFor(testFile as string):
"""
If the first line of the test case file starts with // category CategoryName 
then return a suitable [CategoryName()] attribute.
"""
	match FirstLineOf(testFile):
		case /\/\/\s*ignore\s+(?<reason>.*)/:
			return "[Ignore(\"${reason[0].Value.Trim()}\")]"
		case /\/\/\s*category\s+(?<name>.*)/:
			return "[Category(\"${name[0].Value.Trim()}\")]"
		otherwise:
			return ""
	
def FirstLineOf(fname as string):
	using reader=File.OpenText(fname):
		return reader.ReadLine()

def GenerateTestFixture(srcDir as string, targetFile as string, header as string):
	contents = GenerateTestFixtureSource(srcDir, header)
	if ShouldReplaceContent(targetFile, contents):
		WriteAllText(targetFile, contents)
		
def ShouldReplaceContent(fname as string, contents as string):
	if not File.Exists(fname): return true
	return ns(ReadAllText(fname)) != ns(contents)
	
def ReadAllText(fname as string):
	using reader=File.OpenText(fname):
		return reader.ReadToEnd()
		
def WriteAllText(fname as string, contents as string):
	using writer=StreamWriter(fname):
		writer.Write(contents)
	
def ns(s as string):
"""
Normalize string.
"""
	return s.Trim().Replace("\r\n", Environment.NewLine)
	
def GenerateTestFixtureSource(srcDir as string, header as string):
	writer=StringWriter()
	writer.Write(header)	
	WriteTestCases(writer, srcDir)
	return writer.ToString()

GenerateTestFixture("tests/parser", "src/UnityScript.Tests/ParserTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
partial class ParserTestFixture:
""")

GenerateTestFixture("tests/semantics", "src/UnityScript.Tests/SemanticsTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class SemanticsTestFixture(AbstractSemanticsTestFixture):
""")

GenerateTestFixture("tests/integration", "src/UnityScript.Tests/IntegrationTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class IntegrationTestFixture(AbstractIntegrationTestFixture):
""")

GenerateTestFixture("tests/pragma", "src/UnityScript.Tests/PragmaTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class PragmaTestFixture(AbstractIntegrationTestFixture):
""")

GenerateTestFixture("tests/generics", "src/UnityScript.Tests/GenericsTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class GenericsTestFixture(AbstractIntegrationTestFixture):
""")

GenerateTestFixture("tests/eval", "src/UnityScript.Tests/EvalTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class EvalTestFixture(AbstractIntegrationTestFixture):
""")

GenerateTestFixture("tests/expando", "src/UnityScript.Tests/ExpandoTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class ExpandoTestFixture(AbstractIntegrationTestFixture):
	
	override def CreateCompiler():
		compiler = super()
		compiler.Parameters.Expando = true
		return compiler
""")



GenerateTestFixture("tests/error-messages", "src/UnityScript.Tests/ErrorMessagesTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
partial class ErrorMessagesTestFixture:
""")

GenerateTestFixture("tests/stacktrace", "src/UnityScript.Tests/StackTraceTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework	

partial class StackTraceTestFixture:
""")
