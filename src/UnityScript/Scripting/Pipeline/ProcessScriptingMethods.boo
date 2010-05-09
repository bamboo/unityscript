namespace UnityScript.Scripting.Pipeline

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import UnityScript.Scripting
import UnityScript.Steps

class ProcessScriptingMethods(UnityScript.Steps.ProcessUnityScriptMethods):
"""
Customizes the way simple references are treated by the compiler when
they point to EvaluationContext provided members.
"""

	_evaluationContext as EvaluationContext

	def constructor(evaluationContext as EvaluationContext):
		_evaluationContext = evaluationContext

	override def HasSideEffect(e as Expression):
		// dont enforce side effect statements in scripts
		// because people might want to evaluate simple
		// references
		return true

	override def OnReferenceExpression(node as ReferenceExpression):
		super(node)

		entity = GetOptionalEntity(node) as EvaluationContextEntity
		if entity is null: return

		if not ValidateContext(entity):
			member = entity.Delegate
			Errors.Add(CompilerErrorFactory.InstanceRequired(node, member.DeclaringType.ToString(), member.Name))

		node.ParentNode.Replace(
			node,
			MapToContextReference(entity))

	def ValidateContext(entity as EvaluationContextEntity):
		if not _evaluationContext.IsStaticContext: return true
		if entity.Delegate.IsStatic: return true
		if IsEvaluationContextMember(entity): return true
		return false

	def MapToContextReference(entity as EvaluationContextEntity):

		scriptEntity = entity as ActiveScriptEntity
		if scriptEntity is not null:
			// scripts that contain references to
			// active scripts cannot be cached because
			// script activation is dependent upon
			// the application control flow
			Evaluator.Taint(CompileUnit)
			return GetActiveScriptEntityReference(scriptEntity)

		return CodeBuilder.CreateMemberReference(
			CodeBuilder.CreateReference(
				GetTargetFieldContext(entity)),
				entity.Delegate)

	def GetActiveScriptEntityReference(scriptEntity as ActiveScriptEntity):
		// EvaluationContext.GetActiveScript(scriptId).Member
		return CodeBuilder.CreateMemberReference(
			GetActiveScriptReference(scriptEntity),
			scriptEntity.Delegate)

	def GetActiveScriptReference(scriptEntity as ActiveScriptEntity):
		return CodeBuilder.CreateMethodInvocation(
			CodeBuilder.CreateReference(GetEvaluationContextField()),
			TypeSystemServices.Map(typeof(EvaluationContext).GetMethod("GetActiveScript")),
			CodeBuilder.CreateIntegerLiteral(scriptEntity.Script))

	def GetTargetFieldContext(entity as EvaluationContextEntity):
		if IsEvaluationContextMember(entity):
			return GetEvaluationContextField()
		return GetScriptContainerField()

	def IsEvaluationContextMember(entity as EvaluationContextEntity):
		return entity.Delegate.DeclaringType is TypeSystemServices.Map(_evaluationContext.GetType())

	def GetEvaluationContextField():
		return NameResolutionService.ResolveField(CurrentType, "EvaluationContext")

	def GetScriptContainerField():
		return NameResolutionService.ResolveField(GetScriptClassType(), "ScriptContainer")

	def GetScriptClassType():
		return GetEntity(GetScriptClass(Context))

	def GetOptionalEntity(node as Node):
		return self.TypeSystemServices.GetOptionalEntity(node)

