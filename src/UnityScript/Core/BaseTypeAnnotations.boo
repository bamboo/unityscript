namespace UnityScript.Core

import Boo.Lang.Compiler.Ast

static class BaseTypeAnnotations:

	def AnnotateExtends(baseType as TypeReference):
		baseType.Annotate(Extends)
			
	def AnnotateImplements(baseType as TypeReference):
		baseType.Annotate(Implements)
		
	def HasExtends(baseType as TypeReference):
		return baseType.ContainsAnnotation(Extends)
		
	def HasImplements(baseType as TypeReference):
		return baseType.ContainsAnnotation(Implements)
		
	private Extends = object()
	private Implements = object()

