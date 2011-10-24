namespace UnityScript.Scripting.Pipeline

import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import UnityScript.Scripting

class IntroduceImports(AbstractCompilerStep):
	
	_evaluationContext as EvaluationContext
	
	def constructor(context as EvaluationContext):
		_evaluationContext = context
		
	override def Run():
		imports = _evaluationContext.ScriptContainer.GetImports()
		if imports is not null: AddImports(imports)
		
	def AddImports(imports as (string)):
		for m in CompileUnit.Modules:
			for i in imports:
				m.Imports.Add(Import(i))
			
		