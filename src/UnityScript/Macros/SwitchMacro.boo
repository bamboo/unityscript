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
	
	assert len(switch.Arguments) == 1
	
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
	
	lastItem = switch.Body.Statements[-1]
	for item in switch.Body.Statements:
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
		++_level
		node.Block.Accept(self)
		--_level
		
def NewGoto(label as LabelStatement):
	return GotoStatement(Label: ReferenceExpression(label.Name))

