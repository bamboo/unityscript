namespace UnityScript.Lang

class UnityRuntimeServices:
	
	public static EmptyEnumerator = (,).GetEnumerator()
	
	static EnumeratorType = typeof(System.Collections.IEnumerator)
	
	public static final Initialized as bool
	
	static def constructor():
		Boo.Lang.Runtime.RuntimeServices.RegisterExtensions(Extensions)
		Initialized = true
		
	static def Invoke(target, name as string, args as (object), scriptBaseType as System.Type):
		assert Initialized
		returnValue = Boo.Lang.Runtime.RuntimeServices.Invoke(target, name, args)
		if returnValue is null: return null
		if not IsGenerator(returnValue): return returnValue
		if not target.GetType().IsSubclassOf(scriptBaseType): return returnValue
		if IsStaticMethod(target.GetType(), name, args): return returnValue
		return cast(duck, target).StartCoroutine_Auto(returnValue)
		
	static def GetProperty(target, name as string):
		assert Initialized
		try:
			return Boo.Lang.Runtime.RuntimeServices.GetProperty(target, name)
		except x as System.MissingMemberException:
			if target.GetType().IsValueType: raise
			return ExpandoServices.GetExpandoProperty(target, name)
		
	static def SetProperty(target, name as string, value):
		assert Initialized
		try:
			return Boo.Lang.Runtime.RuntimeServices.SetProperty(target, name, value)
		except x as System.MissingMemberException:
			if target.GetType().IsValueType: raise
			return ExpandoServices.SetExpandoProperty(target, name, value)
			
	static def GetTypeOf(o):
		if o is null: return null
		return o.GetType()
		
	static def IsGenerator(obj):
		type = obj.GetType()
		if type is EnumeratorType: return true
		if EnumeratorType.IsAssignableFrom(type): return true
		return typeof(Boo.Lang.AbstractGenerator).IsAssignableFrom(type)
		
	static def IsStaticMethod(type as System.Type, name as string, args as (object)):
		try:
			// TODO: properly resolve overload
			return type.GetMethod(name).IsStatic
		except x:
			return true
			
	static def GetEnumerator(obj) as System.Collections.IEnumerator:
		if obj is null: return (,).GetEnumerator()
		if IsValueTypeArray(obj) or obj isa UnityScript.Lang.Array:
			return ListUpdateableEnumerator(obj)
		enumerator = obj as System.Collections.IEnumerator
		if enumerator is not null: return enumerator
		return Boo.Lang.Runtime.RuntimeServices.GetEnumerable(obj).GetEnumerator()
		
	static def Update([required] e as System.Collections.IEnumerator, newValue):
		// should we simply ignore here?
		if not e isa ListUpdateableEnumerator: return		
		cast(ListUpdateableEnumerator, e).Update(newValue)
		
	static def IsValueTypeArray(obj):
		if not obj isa System.Array: return false
		return obj.GetType().GetElementType().IsValueType
		
	public abstract class ValueTypeChange:
		public Target as object
		public Value as object
		
		def constructor(target, value):
			self.Target = target
			self.Value = value
			
		IsValid:
			get: return Value isa System.ValueType
			
		abstract def Propagate() as bool:
			pass
			
	public class MemberValueTypeChange(ValueTypeChange):
		
		public Member as string
		
		def constructor(target, member as string, value):
			super(target, value)
			self.Member = member
			
		override def Propagate() as bool:
			if not IsValid: return false
			try:
				Boo.Lang.Runtime.RuntimeServices.SetProperty(Target, Member, Value)
			except x as System.MissingFieldException:
				// hit a readonly property
				return false
			return true
			
	public class SliceValueTypeChange(ValueTypeChange):
		public Index as object
		
		def constructor(target, index, value):
			super(target, value)
			self.Index = index
			
		override def Propagate() as bool:
			if not IsValid: return false
			
			a = Target as System.Collections.IList
			if a is not null:
				a[Index] = Value
				return true
				
			try:
				Boo.Lang.Runtime.RuntimeServices.SetSlice(Target, "", (Index, Value))
			except x as System.MissingFieldException:
				// hit a readonly property
				return false
			return true
		

	static def PropagateValueTypeChanges(changes as (ValueTypeChange)):
		for change in changes:
			if not change.Propagate():
				break
