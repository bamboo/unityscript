namespace UnityScript.Steps

import Boo.Lang.Compiler.Ast

static class EvalAnnotation:
	
	def Mark(node as Method):
		AnnotateEval(node.DeclaringType)
		AnnotateEval(node)
		
	def IsMarked(node as Node):
		return node.ContainsAnnotation(Annotation)
		
	private def AnnotateEval(node as Node):
		if IsMarked(node): return
		node.Annotate(Annotation)
		
	final Annotation = object()