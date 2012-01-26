#!/usr/bin/env booi
"""
Generates test fixtures from files under tests/

First line of test case can specify a nunit attribute to go with it:
	* "// ignore reason" for [Ignore("reason")]
	* "// category name" for [Category("name")]
"""
import System
import System.IO
import Boo.Lang.PatternMatching

def Main():
	GenerateProjectTestFixture("src/UnityScript.Tests/ProjectIntegrationTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework

partial class ProjectIntegrationTestFixture:
""", "tests/projects")

	GenerateTestFixture("src/UnityScript.Tests/ParserTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
partial class ParserTestFixture:
""", "tests/parser")

	GenerateTestFixture("src/UnityScript.Tests/SemanticsTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class SemanticsTestFixture(AbstractSemanticsTestFixture):
""", "tests/semantics")

	GenerateTestFixture("src/UnityScript.Tests/StrictIntegrationTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
partial class StrictIntegrationTestFixture(AbstractIntegrationTestFixture):

""", "tests/integration")

	GenerateTestFixture("src/UnityScript.Tests/DuckyIntegrationTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class DuckyIntegrationTestFixture(AbstractIntegrationTestFixture):
	override def SetCompilationOptions():
		super()
		Parameters.Strict = false
""", "tests/integration", "tests/ducky")

	GenerateTestFixture("src/UnityScript.Tests/PragmaTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class PragmaTestFixture(AbstractIntegrationTestFixture):
""", "tests/pragma")

	GenerateTestFixture("src/UnityScript.Tests/GenericsTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class GenericsTestFixture(AbstractIntegrationTestFixture):
""", "tests/generics")

	GenerateTestFixture("src/UnityScript.Tests/EvalTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class EvalTestFixture(AbstractIntegrationTestFixture):
""", "tests/eval")

	GenerateTestFixture("src/UnityScript.Tests/ExpandoTestFixture.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class ExpandoTestFixture(AbstractIntegrationTestFixture):
	
	override def SetCompilationOptions():
		super()
		Parameters.Expando = true
""", "tests/expando")


	GenerateTestFixture("src/UnityScript.Tests/ErrorMessagesTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework
	
partial class ErrorMessagesTestFixture:
""", "tests/error-messages")

	GenerateTestFixture("src/UnityScript.Tests/StackTraceTestFixture.Generated.boo", """
namespace UnityScript.Tests

import NUnit.Framework	

partial class StackTraceTestFixture:
""", "tests/stacktrace")

def GetTestCaseName(fname as string):
	return Path.GetFileNameWithoutExtension(fname).Replace("-", "_").Replace(".", "_")	
	
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

def GenerateTestFixture(targetFile as string, header as string, *srcDirs as (string)):
	contents = GenerateTestFixtureSource(header, srcDirs, JavascriptFilesIn, CategoryAttributeFor)
	WriteFileIfChanged(targetFile, contents)
	
def GenerateProjectTestFixture(targetFile as string, header as string, *srcDirs as (string)):
	contents = GenerateTestFixtureSource(header, srcDirs, { dir | Directory.GetDirectories(dir) }, { dir | "" })
	WriteFileIfChanged(targetFile, contents)
	
def WriteFileIfChanged(targetFile as string, contents as string):
	if ShouldReplaceContent(targetFile, contents):
		File.WriteAllText(targetFile, contents)
		
def ShouldReplaceContent(fname as string, contents as string):
	if not File.Exists(fname): return true
	return ns(File.ReadAllText(fname)) != ns(contents)
	
def ns(s as string):
"""
Normalize string.
"""
	return s.Trim().Replace("\r\n", Environment.NewLine)
	
def GenerateTestFixtureSource(
	header as string,
	srcDirs as string*,
	testCaseProducer as callable(string) as string*,
	categoryProducer as callable(string) as string):
		
	writer=StringWriter()
	writer.Write(header)	
	for srcDir in srcDirs:
		count = 0
		for testCase in testCaseProducer(srcDir):
			++count
			categoryAttribute = categoryProducer(testCase)
			writer.Write("""
	$categoryAttribute
	[Test] def ${GetTestCaseName(testCase)}():
		RunTestCase("${testCase.Replace('\\', '/')}")
		""")
		print "\t$count test cases found in $srcDir."
	return writer.ToString()
	
def JavascriptFilesIn(dir as string):
	return fname for fname in Directory.GetFiles(dir) if fname.EndsWith(".js")	
