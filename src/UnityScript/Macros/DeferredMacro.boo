namespace UnityScript.Macros

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro deferred:
	case [| deferred $(ReferenceExpression(Name: name)) = $initializer |]:
		p = Property(Name: name)
		p.Getter = [|
			[Boo.Lang.Useful.Attributes.OnceAttribute]
			def get():
				return $initializer
		|]
		yield p


