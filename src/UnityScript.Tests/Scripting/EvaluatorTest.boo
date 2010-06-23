namespace UnityScript.Tests.Scripting

import NUnit.Framework
import UnityScript.Scripting

[TestFixture]
class EvaluatorTest:
	
	[Test]
	def SimpleEvalWithNoImports():
		
		Assert.AreEqual(4, Evaluator.Eval(EvaluationContext(), "2 + 2"))
		
	[Test]
	def SimpleEvalWithImports():
		
		ctx = EvaluationContext(SimpleEvaluationDomainProvider("System.IO"))
		Assert.AreEqual(".js", Evaluator.Eval(ctx, 'Path.GetExtension("file.js")'))
