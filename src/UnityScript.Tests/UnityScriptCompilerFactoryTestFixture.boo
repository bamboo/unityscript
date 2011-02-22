namespace UnityScript.Tests

import NUnit.Framework
import us

import Boo.Lang.Environments
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.TypeSystem.Services

[TestFixture]
class UnityScriptCompilerFactoryTestFixture:

	[Test]
	def Defines():
	
		options = CommandLineOptions(
						"-d:FOO", "--define:BAR",
						
						"-method:Awake", "-base:$MonoBehaviour",
						"-r:$(GetAssemblyLocation())")
						
		compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
		
		Assert.AreEqual(["FOO", "BAR"], [define for define in compiler.Parameters.Defines.Keys])
		
	[Test]
	def CustomTypeInferenceRuleAttribute():
		
		options = CommandLineOptions(
						"-x-type-inference-rule-attribute:$CustomAttribute",
		
						"-method:Awake", "-base:$MonoBehaviour",
						"-r:$(GetAssemblyLocation())")
						
		compiler = UnityScriptCompilerFactory.FromCommandLineOptions(options)
		compiler.Parameters.Pipeline = CompilerPipeline() { ActionStep(CheckCustomTypeInferenceRuleAttribute) }
		result = compiler.Run()
		Assert.AreEqual(0, len(result.Errors), result.Errors.ToString(true))
		
	private def CheckCustomTypeInferenceRuleAttribute():
		method = GetType().GetMethod("MethodWithCustomAttribute")
		rule = my(TypeInferenceRuleProvider).TypeInferenceRuleFor(method)
		Assert.AreEqual("custom", rule)
		
	[CustomAttribute]
	def MethodWithCustomAttribute():
		return null
		
class CustomAttribute(System.Attribute):
	override def ToString():
		return "custom"
		
		
		

	