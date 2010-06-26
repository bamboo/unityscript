namespace UnityScript.TypeSystem

import Boo.Lang.Compiler.TypeSystem
import Boo.Lang.Compiler.TypeSystem.Services

class UnityDowncastPermissions(DowncastPermissions):
	
	[property(Enabled)] _enabled = false
	
	override def CanBeReachedByDowncast(expectedType as IType, actualType as IType):
		if expectedType.IsArray and actualType.IsArray and IsDowncastAllowed():
			return CanBeReachedByArrayDowncast(expectedType, actualType)
		return super(expectedType, actualType)
	
	override protected def IsDowncastAllowed():
		return _enabled or super()
		
	private def CanBeReachedByArrayDowncast(expectedType as IArrayType, actualType as IArrayType):
		return expectedType.Rank == actualType.Rank \
			and CanBeReachedByDowncast(expectedType.ElementType, actualType.ElementType)
