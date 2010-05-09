/*
interface I:

	def f()

interface J:

	def g(n)

class C(I, J):

	def f():
		return null

	def g(n):
		return null
*/

interface I { function f(); } 
interface J { function g(n); } 
 
class C implements I, J { 
	function f() { return null; } 
	function g(n) { return null; } 
} 


