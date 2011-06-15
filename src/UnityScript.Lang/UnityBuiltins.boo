namespace UnityScript.Lang

static class UnityBuiltins:
	
	def eval(code as string) as object:
		raise System.NotImplementedException()

	def parseInt (value as System.String) as int:
		return int.Parse(value)
			
	def parseInt (value as single) as int:
		return value
		
	def parseInt (value as double) as int:
		return value
	
	def parseInt (value as int) as int:
		return value
	
	def parseFloat (value as System.String) as single:
		return single.Parse(value)
		
	def parseFloat (value as single) as single:
		return value
		
	def parseFloat (value as double) as single:
		return value
	
	def parseFloat (value as int) as single:
		return value
