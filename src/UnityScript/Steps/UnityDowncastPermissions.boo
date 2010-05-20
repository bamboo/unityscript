namespace UnityScript.Steps

import Boo.Lang.Compiler
import Boo.Lang.Compiler.TypeSystem.Services

class UnityDowncastPermissions(DowncastPermissions):
	
	[property(Enabled)] _enabled = false
	
	def constructor(context as CompilerContext):
		super(context)
	
	override def IsDowncastAllowed():
		return _enabled or super()
