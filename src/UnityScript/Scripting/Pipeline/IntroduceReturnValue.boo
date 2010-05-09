namespace UnityScript.Scripting.Pipeline

import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import UnityScript.Steps

class IntroduceReturnValue(AbstractCompilerStep):
"""
"""
	override def Run():
		klass = GetScriptClass(Context)
		if klass is null: return
		
		entryPoint as Method = klass.Members["Run"]
		last = LastExpressionStatement(entryPoint)
		if last is null or IsVoid(last.Expression): return
		
		last.ParentNode.Replace(last, ReturnStatement(last.Expression))
		
	def IsVoid(e as Expression):
		return TypeSystemServices.GetExpressionType(e) == TypeSystemServices.VoidType 
		
	def LastExpressionStatement(method as Method):
		body = method.Body.Statements
		if 0 == len(body): return null
		return body[-1] as ExpressionStatement
		
		
		
		