namespace UnityScript.Lang

static class Extensions:

	[Extension]
	def op_Equality(lhs as System.Char, rhs as System.String):
		return 1 == len(rhs) and lhs == rhs[0]	
	
	[Extension]	
	def op_Equality(lhs as System.String, rhs as System.Char):
		return rhs == lhs

	[Extension]
	def op_Inequality(lhs as System.Char, rhs as System.String):
		return 1 != len(rhs) or lhs != rhs[0]	
	
	[Extension]	
	def op_Inequality(lhs as System.String, rhs as System.Char):
		return rhs != lhs

	[Extension]
	length[a as System.Array]:
		get: return a.Length
			
	[Extension]
	length[s as string]:
		get: return s.Length
			
	[Extension]
	def op_Implicit(e as System.Enum) as bool:
		return (e cast System.IConvertible).ToInt32(null) != 0
