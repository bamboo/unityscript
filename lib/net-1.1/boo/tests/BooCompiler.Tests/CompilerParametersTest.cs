using System;
using System.Reflection;
using Boo.Lang.Compiler;
using NUnit.Framework;

namespace BooCompiler.Tests
{
	[TestFixture]
	public class CompilerParametersTest
	{
		[Test]
		public void TestUniqueReferences()
		{
			CompilerParameters parameters = new CompilerParameters();
			int count = parameters.References.Count;

			Assembly reference = Assembly.GetExecutingAssembly();
			for (int i=0; i<2; ++i)
			{
				parameters.AddAssembly(reference);
				Assert.AreEqual(count + 1, parameters.References.Count);
				Assert.IsTrue(parameters.References.Contains(reference));
				parameters.References.Add(reference);
			}
		}
	}
}
