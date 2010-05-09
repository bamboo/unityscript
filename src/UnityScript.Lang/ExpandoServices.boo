namespace UnityScript.Lang

import System
import System.Collections

internal class Expando:
	
	_target as WeakReference
	_attributes = Hashtable()
	
	def constructor(target):
		_target = WeakReference(target)
		
	Target:
		get: return _target.Target
	
	Item[key]:
		get:
			return _attributes[key]
			
		set:
			if value is null:
				_attributes.Remove(key)
			else:
				_attributes[key] = value

class ExpandoServices:
	
	static _expandos = List()
				
	static def GetExpandoProperty(target, name as string):
		expando = GetExpandoFor(target)
		if expando is null: return null		
		return expando.Item[name]
		
	static def SetExpandoProperty(target, name as string, value):		
		expando = GetOrCreateExpandoFor(target)
		expando.Item[name] = value
		return value
	
	[lock(_expandos)]
	static def GetExpandoFor(o) as Expando:
		Purge()
		return _expandos.Find({ e as Expando | e.Target is o })
		
	[lock(_expandos)]
	static def GetOrCreateExpandoFor(o):
		e = GetExpandoFor(o)
		if e is null:
			e = Expando(o)
			_expandos.Add(e)
		return e
		
	static ExpandoObjectCount:
		get:
			Purge()
			return len(_expandos)
		
	[lock(_expandos)]
	static def Purge():
		_expandos.RemoveAll({ e as Expando | e.Target is null })
		
	
