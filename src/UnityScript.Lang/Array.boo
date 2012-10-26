namespace UnityScript.Lang

import System
import System.Collections

class Array(IList, Boo.Lang.Runtime.ICoercible):
	
	InnerList = System.Collections.Generic.List of object()

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
			
	def GetEnumerator():
		return InnerList.GetEnumerator()
		
	def CopyTo(target as System.Array, targetIndex as int):
		elementType = target.GetType().GetElementType()
		elementsToCopy = Math.Min(len(target) - targetIndex, Count)
		sourceIndex = 0
		while sourceIndex < elementsToCopy:
			rawArrayIndexing:
				target[targetIndex++] = Boo.Lang.Runtime.RuntimeServices.Coerce(InnerList[sourceIndex++], elementType)
			
	Count:
		get: return InnerList.Count
		
	ICollection.IsSynchronized:
		get: return false
		
	ICollection.SyncRoot:
		get: return self
		
	def Clear():
		InnerList.Clear()
		
	def Contains(o):
		return InnerList.Contains(o)
		
	def IndexOf(o):
		return InnerList.IndexOf(o)
		
	def Insert(index as int, element):
		InnerList.Insert(index, element)
		
	def RemoveAt(index as int):
		InnerList.RemoveAt(index)
		
	IList.IsReadOnly:
		get: return false
		
	IList.IsFixedSize:
		get: return false

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
		result = System.Array.CreateInstance(type, Count)
		CopyTo(result, 0)
		return result
	
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
	
	def Sort(comparison as Comparison):
		self.InnerList.Sort({ x, y | comparison(x, y) })
		
	def sort(comparison as Comparison):
		Sort(comparison)

	# Sort
	def Sort() as Array:
		self.InnerList.Sort()
		return self

	def sort() as Array:
		return self.Sort()

	# Combine to a string
	def Join (seperator as String):
		return Builtins.join(self.InnerList, seperator)
	
	def join (seperator as String):
		return self.Join(seperator)	

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
		arr.AddRange(value)
		for item as ICollection in items:
			arr.AddRange(item)
		return arr

	private def EnsureCapacity(capacity as int):
		return if capacity < Count
		for i in range(capacity-self.Count):
			InnerList.Add(null)		
			
	private def NormalizeIndex(index as int):
		return index if index >= 0
		return index + InnerList.Count
