namespace UnityScript.Macros

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

class CaseStatement(CustomStatement):
	public Expressions as ExpressionCollection
	public Body as Block
	
class DefaultStatement(CustomStatement):
	public Body as Block
	
macro switch:
	
	if len(switch.Arguments) != 1:
		Errors.Add(CompilerErrorFactory.CustomError(switch, "switch requires an expression."))
		return null
		
	statements = switch.Body.Statements
	if len(statements) == 0:
		Warnings.Add(CompilerWarningFactory.CustomWarning(switch, "switch statement has no cases."))
		return null
	
	macro case:
		return CaseStatement(Expressions: case.Arguments, Body: case.Body)
		
	macro default():
		return DefaultStatement(Body: default.Body)

	def UniqueName():
		return Context.GetUniqueName("switch")		

	def NewLabel():
		return LabelStatement(Name: UniqueName())
		
	local = ReferenceExpression(UniqueName())
	endLabel = NewLabel()
	
	// local = <expression>
	block = Block()
	block.Add([| $local = $(switch.Arguments[0]) |])
			
	passThrough as LabelStatement
	
	lastItem = statements[-1]
	for item in statements:
		match item:
			
			case CaseStatement(Expressions: expressions, Body: body):
			
				condition = ComparisonFor(local, expressions)
				stmt = [|
					if $condition:
						pass
				|]
				
				if passThrough is not null:
					stmt.TrueBlock.Add(passThrough)
					passThrough = null
				stmt.TrueBlock.Add(body)
				if item is not lastItem and not EndsWithBreak(body):
					passThrough = NewLabel()
					stmt.TrueBlock.Add(NewGoto(passThrough))
				block.Add(stmt)
				
			case DefaultStatement(Body: body):
				if passThrough is not null: block.Add(passThrough)
				block.Add(body)

	block.Accept(GotoOnTopLevelBreak(endLabel))
	block.Add(endLabel)
	return block
	
def ComparisonFor(local as Expression, expressions as Expression*):
	e = expressions.GetEnumerator()
	assert e.MoveNext()
	condition as Expression = [| $local == $(e.Current) |]
	while e.MoveNext():
		condition = [| $condition or $local == $(e.Current) |]
	return condition
		
def EndsWithBreak(block as Block):
	if 0 == len(block.Statements): return false
	return block.Statements[-1] isa BreakStatement
			
class GotoOnTopLevelBreak(DepthFirstTransformer):
	_label as LabelStatement
	_level = 0
	
	def constructor(label as LabelStatement):
		_label = label
		
	override def OnBreakStatement(node as BreakStatement):
		if _level > 0: return
		ReplaceCurrentNode(NewGoto(_label))
		
	override def OnWhileStatement(node as WhileStatement):
		OnLoopBody node.Block
		
	override def OnForStatement(node as ForStatement):
		OnLoopBody node.Block
		
	def OnLoopBody(block as Block):
		++_level
		block.Accept(self)
		--_level
		
def NewGoto(label as LabelStatement):
	return GotoStatement(Label: ReferenceExpression(label.Name))

