namespace UnityScript.Scripting.Pipeline

import Boo.Lang.Compiler.Steps
import UnityScript.Scripting
import UnityScript.Steps

class IntroduceEvaluationContext(AbstractCompilerStep):
"""
Introduce the constructor and field support for holding
the EvaluationContext inside the script class.
"""
	
	_evaluationContext as EvaluationContext
	
	def constructor(evaluationContext as EvaluationContext):
		_evaluationContext = evaluationContext
		
	override def Run():
		klass = GetScriptClass(Context)
		if klass is null: return
		klass.Merge(GetContextFieldDeclaration())
		
	def GetContextFieldDeclaration():
		evaluationContextType = _evaluationContext.GetType()
		scriptContainerType = _evaluationContext.ScriptContainer.GetType()
		
		return [|
			class _:
				public static ScriptContainer as $scriptContainerType
				EvaluationContext as $evaluationContextType
				
				def constructor(context as $evaluationContextType):
					self.EvaluationContext = context
					ScriptContainer = context.ScriptContainer
		|]
		
