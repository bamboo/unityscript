namespace UnityScript.Steps

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.Steps
import UnityScript.Core
import UnityScript.Parser

class Parse(AbstractCompilerStep):
	
	override def Run():
		ParseInputs()
		NormalizePropertyAccessors()
		
	private def ParseInputs():
		for input in self.Parameters.Input:
			try:
				ParseInput(input)
			except x:
				Errors.Add(CompilerErrorFactory.InputError(input.Name, x))
				
	private def NormalizePropertyAccessors():
		CompileUnit.Accept(PropertyAccessorNormalizer(Errors: Errors))

	private def ParseInput(input as ICompilerInput):
		using reader = input.Open():
			UnityScriptParser.ParseReader(reader, input.Name, self.Context, self.CompileUnit)
			
	class PropertyAccessorNormalizer(FastDepthFirstVisitor):
		property Errors as CompilerErrorCollection
		
		override def OnProperty(node as Property):
			NormalizeSetter node.Setter
			NormalizeGetter node.Getter
			
		def NormalizeSetter(setter as Method):
			if setter is null:
				return
			NormalizeSetterParameters setter
			CheckSetterReturnType setter
			
		def NormalizeSetterParameters(setter as Method):
			if setter.Parameters.Count != 1 or setter.Parameters[0].Name != "value":
				ReportError(UnityScriptCompilerErrors.InvalidPropertySetter(setter.LexicalInfo))
				return
			setter.Parameters.Clear()
			
		def CheckSetterReturnType(setter as Method):
			if setter.ReturnType is null:
				return
			ReportError(UnityScriptCompilerErrors.SetterCanNotDeclareReturnType(setter.ReturnType.LexicalInfo))
			
		def NormalizeGetter(getter as Method):
			if getter is null or getter.Parameters.Count == 0:
				return
			ReportError(UnityScriptCompilerErrors.InvalidPropertyGetter(getter.LexicalInfo))
			
		def ReportError(error as CompilerError):
			Errors.Add(error)
