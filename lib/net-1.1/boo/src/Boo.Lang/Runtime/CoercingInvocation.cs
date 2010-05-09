using System;
using System.Reflection;

namespace Boo.Lang.Runtime
{
	public class CoercingInvocation : InvocationDispatcherBase
	{
		public CoercingInvocation(MethodInfo method) : base(method)
		{
		}

		public object Invoke(object target, object[] args)
		{
			CoerceAll(args);
			return _method.Invoke(target, args);
		}
	}
}
