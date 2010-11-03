namespace UnityScript.Tests.Core

import NUnit.Framework
import Boo.Lang.Compiler.Ast
import UnityScript.Core


[TestFixture]
class PragmasTest:
	
	[Test]
	def GivenIsNotEnabledWhenTryToEnableOnThenIsEnabledOnReturnsTrue():
		
		m = Module()
		for pragma in Pragmas.All:
			assert not Pragmas.IsEnabledOn(m, pragma)
			assert Pragmas.TryToEnableOn(m, pragma)
			assert Pragmas.IsEnabledOn(m, pragma)
			
			
	[Test]
	def GivenIsDisabledWhenTryToEnabledOnThenIsEnabledOnReturnsFalse():
		
		m = Module()
		for pragma in Pragmas.All:
			Pragmas.DisableOn(m, pragma)
			assert not Pragmas.TryToEnableOn(m, pragma)
			assert not Pragmas.IsEnabledOn(m, pragma)
		
	
	
