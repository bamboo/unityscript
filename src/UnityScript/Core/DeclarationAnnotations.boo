namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class DeclarationAnnotations:

	def ForceNewVariable(d as Declaration):
		d.Annotate(NewVariableAnnotation)
		
	def ShouldForceNewVariableFor(d as Declaration):
		return d.ContainsAnnotation(NewVariableAnnotation)
		
	NewVariableAnnotation = object()

