namespace UnityScript.TypeSystem

import Boo.Lang.Compiler.TypeSystem

class UnityScriptTypeSystem(TypeSystemServices):	

	public static final UnityScriptEval = BuiltinFunction("eval", BuiltinFunctionType.Custom)
	
	public static final UnityScriptTypeof = BuiltinFunction("typeof", BuiltinFunctionType.Custom)
	
	[getter(ScriptBaseType)]
	_ScriptBaseType as IType
	_AbstractGenerator as IType
	
	def constructor():		
		self._ScriptBaseType = Map(UnityScriptParameters.ScriptBaseType)
		self._AbstractGenerator = Map(Boo.Lang.AbstractGenerator)
		
	UnityScriptParameters as UnityScript.UnityScriptCompilerParameters:
		get: return self.Context.Parameters
			
	def IsScriptType(type as IType):
		return type.IsSubclassOf(_ScriptBaseType)
		
	def IsGenerator(method as IMethod):
		rt = method.ReturnType
		if rt is IEnumeratorType: return true
		// for backwards compatibility
		return rt.IsSubclassOf(self._AbstractGenerator)
		
	override def CanBeReachedByPromotion(expected as IType, actual as IType):
		result = super(expected, actual)
		if result: return true
		if expected.IsEnum: return IsIntegerNumber(actual)
		if actual.IsEnum: return IsIntegerNumber(expected)
		return false
		
	override protected def PreparePrimitives():
		AddPrimitiveType("void", VoidType)
		AddPrimitiveType("boolean", BoolType)
		AddPrimitiveType("char", CharType)
		AddPrimitiveType("Date", DateTimeType)
		AddPrimitiveType("String", StringType)
		AddPrimitiveType("Object", ObjectType)
		AddPrimitiveType("Regex", RegexType)
		AddPrimitiveType("sbyte", SByteType)
		AddPrimitiveType("byte", ByteType)
		AddPrimitiveType("short", ShortType)
		AddPrimitiveType("ushort", UShortType)
		AddPrimitiveType("int", IntType)
		AddPrimitiveType("uint", UIntType)
		AddPrimitiveType("long", LongType)
		AddPrimitiveType("ulong", ULongType)
		AddPrimitiveType("Number", DoubleType)
		AddPrimitiveType("float", SingleType)
		AddPrimitiveType("double", DoubleType)
		AddPrimitiveType("Function", ICallableType)
		AddPrimitiveType("Array", Map(UnityScript.Lang.Array))
		
	override def PrepareBuiltinFunctions():
		super()
		AddBuiltin(UnityScriptEval)
		AddBuiltin(UnityScriptTypeof)
