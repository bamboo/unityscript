using System.Reflection;

namespace Boo.Lang.Runtime
{
	public abstract class InvocationDispatcherBase
	{
		protected MethodInfo _method;

		public InvocationDispatcherBase(MethodInfo method)
		{
			_method = method;
		}

		protected void CoerceAll(object[] args)
		{
			ParameterInfo[] parameters = _method.GetParameters();
			for (int i=0; i<args.Length; ++i)
				args[i] = RuntimeServices.Coerce(args[i], parameters[i].ParameterType);
		}
	}
}