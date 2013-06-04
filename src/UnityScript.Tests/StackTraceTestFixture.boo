namespace UnityScript.Tests

import NUnit.Framework

[TestFixture]
[Category("FailsOnMono")]
partial class StackTraceTestFixture(AbstractIntegrationTestFixture):
	override def ExecuteScript(type as System.Type):
		try:
			script as duck = type()
			script.Awake()
		except x:
			System.Console.WriteLine(x)
			
	override def VerifyOutput(expected as string, actual as string):
	"""
	@param expected: each line is in the form "filename:line-number"
	@param actual: contains the exception stack trace
	"""
		actualLines = array(lines(actual))
		for line in lines(expected):
			AssertContains(actualLines, AdjustStackTraceLine(line))
			
	def AdjustStackTraceLine(line as string):
		if Boo.Lang.Useful.PlatformInformation.IsMono: return line
		return join(/:/.Split(line), ":line ")
			
	def AssertContains(items as (string), expected as string):
		for item in items:
			if item.EndsWith(expected): return
		Assert.Fail("Expecting '${expected}', found '${join(items, '\n')}'")
			
	def lines(s as string):
		for line in /\n/.Split(s):
			line = line.Trim()
			if len(line) > 0: yield line
