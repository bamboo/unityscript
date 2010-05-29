namespace UnityScript.Lang

import System.Collections

internal class ListUpdateableEnumerator(IEnumerator):
	
	_list as IList	
	_current = -1
	
	def constructor(list as IList):
		_list = list
	
	def Reset():
		_current = -1
		
	def MoveNext():
		++_current
		return _current < _list.Count
		
	Current:
		get: return _list[_current]
			
	def Update(newValue):
		_list[_current] = newValue