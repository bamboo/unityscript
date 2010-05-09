namespace UnityScript.Lang

class UnityBuiltins:
	
	static def eval(code as string):
		return null

	static def parseInt (value as System.String) as int:
		return int.Parse(value)
			
	static def parseInt (value as single) as int:
		return value
	
	static def parseInt (value as int) as int:
		return value
	
	static def parseFloat (value as System.String) as single:
		return single.Parse(value)
		
	static def parseFloat (value as single) as single:
		return value
	
	static def parseFloat (value as int) as single:
		return value
