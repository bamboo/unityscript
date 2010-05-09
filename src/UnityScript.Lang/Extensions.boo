namespace UnityScript.Lang

class Extensions:

	[Extension]
	static def op_Equality(lhs as System.Char, rhs as System.String):
		return 1 == len(rhs) and lhs == rhs[0]	
	
	[Extension]	
	static def op_Equality(lhs as System.String, rhs as System.Char):
		return rhs == lhs

	[Extension]
	static def op_Inequality(lhs as System.Char, rhs as System.String):
		return 1 != len(rhs) or lhs != rhs[0]	
	
	[Extension]	
	static def op_Inequality(lhs as System.String, rhs as System.Char):
		return rhs != lhs

	[Extension]
	static length[a as System.Array]:
		get:
			return a.Length
			
	[Extension]
	static length[s as string]:
		get:
			return s.Length
			
	[Extension]
	static def op_Implicit(e as System.Enum) as bool:
		return cast(System.IConvertible, e).ToInt32(null) != 0
