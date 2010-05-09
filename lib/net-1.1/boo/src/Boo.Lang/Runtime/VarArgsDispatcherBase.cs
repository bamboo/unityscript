using System;
using System.Reflection;

namespace Boo.Lang.Runtime
{
	internal class VarArgsDispatcherBase : InvocationDispatcherBase
	{
		protected readonly int _minimumArgumentCount;
		protected readonly Type _varArgsParameterType;

		public VarArgsDispatcherBase(MethodInfo method, Type varArgsParameterType, int minimumArgumentCount) : base(method)
		{
			_varArgsParameterType = varArgsParameterType;
			_minimumArgumentCount = minimumArgumentCount;
		}

		
	}
}