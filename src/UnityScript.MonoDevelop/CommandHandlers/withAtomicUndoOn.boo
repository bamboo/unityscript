namespace UnityScript.MonoDevelop.CommandHandlers

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro withAtomicUndoOn(buffer as Expression):
	yield [| $buffer.BeginAtomicUndo() |]
	yield [|
		try:
			$(withAtomicUndoOn.Body)
		ensure:
			$buffer.EndAtomicUndo()
	|]
