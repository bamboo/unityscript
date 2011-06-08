namespace UnityScript.Lang

import System
import System.Collections

class Array(CollectionBase, Boo.Lang.Runtime.ICoercible):

	def constructor():
		pass
		
	def constructor([required(capacity >= 0)] capacity as int):
		EnsureCapacity(capacity)
		
	def constructor(collection as IEnumerable):
		if collection isa String:
			Add(collection)
		else:
			AddRange(collection)
			
	def constructor(*items):
		if len(items) == 1 and items[0] isa IEnumerable:
			AddRange(items[0])
		else:
			AddRange(items)

	static def op_Implicit(e as IEnumerable) as Array:
		if e is null: return null
		return Array(e)
		
	static def op_Implicit(a as System.Array) as Array:
		if a is null: return null
		return Array((a as IEnumerable))

	length:
		get:
			return self.Count
		set:
			EnsureCapacity(value)

			if value < self.Count:
				self.InnerList.RemoveRange(value, InnerList.Count - value)
	
	def clear():
		Clear()
		
	def Coerce(toType as System.Type):
		if toType.IsArray: return ToBuiltin(toType.GetElementType())
		return self
	
	def ToBuiltin(type as System.Type):
		return self.InnerList.ToArray(type)
	
	def Add(value as object, *items):
		self.AddImpl(value, items)
	
	def Add(value as object):
		self.InnerList.Add(value)
		
	def Push(value as object, *items):
		return self.AddImpl(value, items)
			
	def push(value as object, *items):
		return self.AddImpl(value, items)
		
	// workaround for mono reflection bug
	def push(value as object):
		self.InnerList.Add(value)
		return self.InnerList.Count
		
	def Push(value as object):
		return self.push(value)

	def Unshift(value as object, *items):
		return self.UnshiftImpl(value, items)

	def unshift(value as object, *items):
		return self.UnshiftImpl(value, items)

	def Splice (index as int, howmany as int, *items):
		SpliceImpl (index, howmany, items)
		
	def splice (index as int, howmany as int, *items):
		SpliceImpl (index, howmany, items)

	# How do i allow the vararg only for ICollections?
	def Concat(value as ICollection, *items):
		return ConcatImpl(value, items)
		
	# How do i allow the vararg only for ICollections?
	def concat(value as ICollection, *items):
		return ConcatImpl(value, items)

	# Pop last and return
	def Pop():
		last = self.InnerList.Count - 1
		popped = self.InnerList[last]
		self.InnerList.RemoveAt(last)
		return popped

	def pop():
		return self.Pop()

	# Remove first element
	def Shift():
		first = 0
		popped = self.InnerList[first]
		self.InnerList.RemoveAt(0)
		return popped

	def shift():
		return self.Shift()
	
	# Convert to string
	def ToString ():
		return self.Join(",")
		
	def toString ():
		return ToString()

	# Returns array with elements removed
	def Slice(start as int, end as int):
		normalStart = NormalizeIndex(start)
		normalEnd = NormalizeIndex(end)
		return Array(InnerList.GetRange(normalStart, normalEnd - normalStart))
		
	def Slice(start as int):
		return self.Slice(start, self.InnerList.Count)

	def slice(start as int, end as int):
		return self.Slice(start, end)

	def slice(start as int):
		return self.Slice(start)

	# Revert
	def Reverse() as Array:
		self.InnerList.Reverse()
		return self

	def reverse() as Array:
		self.Reverse()
		return self
		
	callable Comparison(lhs as object, rhs as object) as int
	
	private class ComparisonComparer(IComparer):
		def constructor(comparison as Comparison):
			_comparison = comparison
		def Compare(lhs, rhs):
			return _comparison(lhs, rhs)
		_comparison as Comparison
	
	def Sort(comparison as Comparison):
		self.InnerList.Sort(ComparisonComparer(comparison))
		
	def sort(comparison as Comparison):
		Sort(comparison)

	# Sort
	def Sort() as Array:
		self.InnerList.Sort()
		return self

	def sort() as Array:
		self.Sort()
		return self

	# Combine to a string
	def Join (seperator as String):
		return Builtins.join(self.InnerList, seperator)
	
	def join (seperator as String):
		return Builtins.join(self.InnerList, seperator)	

	# Remove
	def Remove (obj as Object):
		self.InnerList.Remove(obj)
	
	def remove (obj as Object):
		self.Remove(obj)
	
	self[index as int] as object:
		get:
			return self.InnerList[index]
		set:
			EnsureCapacity(index+1)
			self.InnerList[index] = value
			
	def AddRange([required] collection as IEnumerable):
		for item in collection:
			self.InnerList.Add(item)
			
	override protected def OnValidate(newValue):
		pass // anything goes

	private def AddImpl(value as object, [required] items as IEnumerable):
		self.InnerList.Add(value)
		
		for item in items:
			self.InnerList.Add(item)
		return self.InnerList.Count

	private def UnshiftImpl(value as object, [required] items as IEnumerable):
		self.InnerList.InsertRange(0, items)
		self.InnerList.Insert(0, value)
		return self.InnerList.Count

	private def SpliceImpl (index as int, howmany as int, [required] items as IEnumerable):
		if howmany != 0:
			self.InnerList.RemoveRange(index, howmany)
		self.InnerList.InsertRange(index, items)

	private def ConcatImpl(value as ICollection, [required] items as IEnumerable):
		arr = Array (self.InnerList)
		arr.InnerList.AddRange(value)

		for item as ICollection in items:
			arr.InnerList.AddRange(item)

		return arr

	private def EnsureCapacity(capacity as int):
		return if capacity < Count
		for i in range(capacity-self.Count):
			InnerList.Add(null)		
			
	private def NormalizeIndex(index as int):
		return index if index >= 0
		return index + InnerList.Count
