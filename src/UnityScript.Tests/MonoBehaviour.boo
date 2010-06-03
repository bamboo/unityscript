namespace UnityScript.Tests

import System.Collections

struct Vector3:

	x as single
	y as single
	z as single

	def constructor(x_ as single, y_ as single, z_ as single):
		x = x_
		y = y_
		z = z_

class Component:
	pass
	
struct Bounds:
	def IntersectRay(ray as Ray, ref result as single):
		result = 42.0
		return true
		
	def IntersectRay(ray as Ray):
		return true
		
struct Ray:
	[property(position)]
	m_Position as Vector3

class Transform(Component):
	[property(position)]
	m_Position = Vector3()
	
	[getter(collider)]
	m_Collider = Collider()
	
class Collider(Component):
	[getter(bounds)]
	m_Bounds = Bounds()

class ComponentFoo(Component):
	def Foo():
		print "foo"

	[property(fooFloat)]
	_fooFloat as single = 0.0;

	[property(fooVector3)]
	_fooVector3 = Vector3();

class ComponentBar(Component):
	def Bar():
		print "bar"

enum AttributeMaskEnum:
	None = 0
	Foo = 1
	Bar = 2

class AttributeWithMask (System.Attribute):
	[getter(mask)]
	_mask = AttributeMaskEnum.None

	def constructor(a as AttributeMaskEnum):
		_mask = a

class ImplicitBoolTest:
	bool_casted = false
	def constructor(a as bool):
		bool_casted = a

	public static def op_Implicit (test as ImplicitBoolTest) as bool:
		return test.bool_casted

class MonoBehaviour(Component):

	_foo = ComponentFoo()
	_bar = ComponentBar()

	def constructor():
		// make sure UnityRuntimeServices is initialized
		// just by accessing the Initialized field
		// we're triggering initialization
		assert UnityScript.Lang.UnityRuntimeServices.Initialized
		
	[getter(transform)]
	m_Transform = Transform()

	def StartCoroutine_Auto(routine as IEnumerator):
		print("Received coroutine")
		routine.MoveNext()
		return routine.Current

	[DuckTyped]
	def GetComponent(type as System.Type) as Component:
		return _foo if ComponentFoo is type
		return _bar

	[DuckTyped]
	def implicit_bool_test_false() as ImplicitBoolTest:
		return ImplicitBoolTest (false)

	[DuckTyped]
	def implicit_bool_test_true() as ImplicitBoolTest:
		return ImplicitBoolTest (true)

	class Time:
		static time as single:
			get:
				return 2.0


