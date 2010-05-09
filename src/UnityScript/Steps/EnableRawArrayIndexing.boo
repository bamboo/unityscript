namespace UnityScript.Steps

import Boo.Lang.Compiler.Steps

class EnableRawArrayIndexing(AbstractCompilerStep):

	override def Run():
		for module in CompileUnit.Modules:
			AstAnnotations.MarkRawArrayIndexing(module)