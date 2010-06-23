namespace UnityScript.Tests.Scripting

import NUnit.Framework
import UnityScript.Scripting

[TestFixture]
class EvaluatorTest:
	
	[Test]
	def SimpleEvalWithNoImports():
		
		Assert.AreEqual(4, Evaluator.Eval(EvaluationContext(null), "2 + 2"))
		
	[Test]
	def SimpleEvalWithImports():
		pass /*
		ctx = EvaluationContext(SimpleEvaluationDomainProvider("System.IO"))
		Assert.AreEqual(".js", Evaluator.Eval(ctx, 'Path.GetExtension("file.js")'))*/
