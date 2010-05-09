namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.TypeSystem

class ProcessAssignmentToDuckMembers(ProcessAssignmentsToSpecialMembers):
	
	_valueTypeChangeType as IType
	_valueTypeChangeConstructor as IConstructor
	_sliceValueTypeChangeConstructor as IConstructor
	_propagateChanges as IMethod
	
	override def Initialize(context as CompilerContext):
		super(context)
		valueTypeChangeType = typeof(UnityScript.Lang.UnityRuntimeServices.MemberValueTypeChange)
		_valueTypeChangeConstructor = self.TypeSystemServices.Map(valueTypeChangeType.GetConstructors()[0])		

		_valueTypeChangeType = self.TypeSystemServices.Map(UnityScript.Lang.UnityRuntimeServices.ValueTypeChange)
		
		sliceValueTypeChangeType = typeof(UnityScript.Lang.UnityRuntimeServices.SliceValueTypeChange)
		_sliceValueTypeChangeConstructor = self.TypeSystemServices.Map(sliceValueTypeChangeType.GetConstructors()[0])
				
		_propagateChanges = self.TypeSystemServices.Map(UnityScript.Lang.UnityRuntimeServices.PropagateValueTypeChanges.Method)
		
	override def IsSpecialMemberTarget(node as Expression):
		return self.TypeSystemServices.IsQuackBuiltin(node)
		
	override def IsReadOnlyMember(node as MemberReferenceExpression):
		return false if IsSpecialMemberTarget(node)
		return super(node)
		
	override def WalkMemberChain(memberRef as MemberReferenceExpression):
		chain = []
		while true:			
			container = memberRef.Target as MemberReferenceExpression
			if (container is null 
				or (IsSpecialMemberTarget(container)
					and IsReadOnlyMember(container))):
				Warnings.Add(
					CompilerWarningFactory.AssignmentToTemporary(memberRef))
				return null
				
			if IsSpecialMemberTarget(container) and not IsFieldReference(container):
				chain.Insert(0, ChainItem(container))
				
			if (container.Target isa MethodInvocationExpression 
				or container.Target isa SlicingExpression):
				chain.Insert(0, ChainItem(container.Target))
				break

			if IsTerminalReferenceNode(container.Target):				
				break
			memberRef = container
			
		return chain
		
	def IsFieldReference(node as Node):
		return EntityType.Field == TypeSystemServices.GetEntity(node).EntityType
		
	def CreateConstructorInvocation(ctor as IConstructor, *args as (Expression)):
		invocation = self.CodeBuilder.CreateConstructorInvocation(ctor)
		for arg in args:
			invocation.Arguments.Add(arg)
		return invocation
			
	override def PropagateChanges(eval as MethodInvocationExpression, chain as List):	
		
		changes = ExpressionCollection()
		
		for item as ChainItem in chain.Reversed:
			if item.Container isa MethodInvocationExpression:
				break
				
			if item.Container isa SlicingExpression:
				slicing as SlicingExpression = item.Container
				changes.Add(
					CreateConstructorInvocation(
						_sliceValueTypeChangeConstructor,
						slicing.Target.CloneNode(),
						slicing.Indices[0].Begin.CloneNode(),
						CodeBuilder.CreateReference(item.Local)))
				break
				
			container as MemberReferenceExpression = item.Container
			changes.Add(
				CreateConstructorInvocation(
					_valueTypeChangeConstructor,
					container.Target.CloneNode(),
					CodeBuilder.CreateStringLiteral(container.Name),
					CodeBuilder.CreateReference(item.Local)))
			
		invocation = CodeBuilder.CreateMethodInvocation(_propagateChanges)
		
		arrayType = _valueTypeChangeType.MakeArrayType(1)
		invocation.Arguments.Add(CodeBuilder.CreateArray(arrayType, changes))		
		eval.Arguments.Add(invocation)