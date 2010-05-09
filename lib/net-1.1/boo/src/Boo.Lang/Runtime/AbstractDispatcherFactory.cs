using System;
using System.Collections;
using System.Reflection;

namespace Boo.Lang.Runtime
{
	public class AbstractDispatcherFactory
	{
		private ExtensionRegistry _extensions;
		private object _target;
		protected Type _type;
		protected string _name;
		private object[] _arguments;

		public AbstractDispatcherFactory(ExtensionRegistry extensions, object target, Type type, string methodName, params object[] arguments)
		{
			_extensions = extensions;
			_target = target;
			_type = type;
			_name = methodName;
			_arguments = arguments;
		}

		private static object[] ExtensionArgsFor(object target, object[] args)
		{
			object[] extensionArgs = new object[args.Length + 1];
			extensionArgs[0] = target;
			Array.Copy(args, 0, extensionArgs, 1, args.Length);
			return extensionArgs;
		}


		protected object[] GetExtensionArgs()
		{
			return ExtensionArgsFor(_target, _arguments);
		}

		protected Type[] GetArgumentTypes()
		{
			return MethodResolver.GetArgumentTypes(_arguments);
		}

		protected Type[] GetExtensionArgumentTypes()
		{
			return MethodResolver.GetArgumentTypes(GetExtensionArgs());
		}

		protected CandidateMethod ResolveExtension(IEnumerable candidates)
		{
			MethodResolver resolver = new MethodResolver(GetExtensionArgumentTypes());
			return resolver.ResolveMethod(candidates);
		}

		protected IEnumerable GetExtensions(MemberTypes memberTypes)
		{
			List found = new List();
			foreach (MemberInfo m in _extensions.Extensions)
			{	
				if (m.MemberType != memberTypes) continue;
				if (m.Name != _name) continue;
				found.Add(m);
			}
			return found;
		}

		protected IEnumerable GetCandidates()
		{
			List found = new List();
			foreach (MethodInfo method in _type.GetMethods(RuntimeServices.DefaultBindingFlags))
			{
				if (_name != method.Name) continue;
				found.Add(method);
			}
			return found;
		}

		protected Dispatcher EmitExtensionDispatcher(CandidateMethod found)
		{
			if (found.DoesNotRequireConversions)
			{
				if (found.VarArgs)
					return new Dispatcher(new VarArgsExtensionDispatcher(found.Method, found.VarArgsParameterType, found.MinimumArgumentCount).Invoke);
				return new Dispatcher(new ExtensionMethodDispatcher(found.Method).Invoke);
			}
			throw new NotImplementedException();
		}

		class ExtensionMethodDispatcher
		{
			private MethodInfo _method;

			public ExtensionMethodDispatcher(MethodInfo method)
			{
				_method = method;
			}

			public object Invoke(object target, object[] args)
			{
				return _method.Invoke(null, ExtensionArgsFor(target, args));
			}
		}

		protected MissingFieldException MissingField()
		{
			return new MissingFieldException(_type.FullName, _name);
		}

		protected CandidateMethod ResolveMethod(Type[] types, IEnumerable candidates)
		{
			return new MethodResolver(types).ResolveMethod(candidates);
		}

		protected Dispatcher EmitMethodDispatcher(CandidateMethod found, Type[] argumentTypes)
		{
			if (found.VarArgs)
				if (found.Method.IsStatic)
					return new Dispatcher(new VarArgsInvocationDispatcher(found.Method, found.VarArgsParameterType, found.MinimumArgumentCount).InvokeStatic);
				else
					return new Dispatcher(new VarArgsInvocationDispatcher(found.Method, found.VarArgsParameterType, found.MinimumArgumentCount).InvokeInstance);
			
			if (found.DoesNotRequireConversions)
				return new Dispatcher(found.Method.Invoke);

			return new Dispatcher(new CoercingInvocation(found.Method).Invoke);
		}
	}

	class VarArgsExtensionDispatcher : VarArgsDispatcherBase
	{
		public VarArgsExtensionDispatcher(MethodInfo method, Type varArgsParameterType, int minimumArgumentCount) : base(method, varArgsParameterType, minimumArgumentCount)
		{
		}

		public object Invoke(object target, object[] args)
		{
			return _method.Invoke(null, PrepareArguments(target, args));
		}

		protected object[] PrepareArguments(object target, object[] args)
		{
			object[] actual = new object[_minimumArgumentCount + 1];
			actual[0] = target;
			for (int i = 0; i<_minimumArgumentCount; ++i)
				actual[i + 1] = args[i];
			actual[_minimumArgumentCount] = VarArgsFor(args);
			CoerceAll(actual);
			return actual;
		}

		private Array VarArgsFor(object[] args)
		{
			int count = args.Length - _minimumArgumentCount + 1;
			Array varArgs = Array.CreateInstance(_varArgsParameterType, count);
			Array.Copy(args, _minimumArgumentCount - 1, varArgs, 0, count);
			return varArgs;
		}
	}

	class VarArgsInvocationDispatcher : VarArgsDispatcherBase
	{
		public VarArgsInvocationDispatcher(MethodInfo method, Type varArgsParameterType, int minimumArgumentCount) : base(method, varArgsParameterType, minimumArgumentCount)
		{
		}

		public object InvokeStatic(object target, object[] args)
		{
			return _method.Invoke(null, PrepareArguments(target, args));
		}

		public object InvokeInstance(object target, object[] args)
		{
			return _method.Invoke(target, PrepareArguments(target, args));
		}

		protected object[] PrepareArguments(object target, object[] args)
		{
			object[] actual = new object[_minimumArgumentCount + 1];
			for (int i = 0; i<_minimumArgumentCount; ++i)
				actual[i] = args[i];
			actual[_minimumArgumentCount] = VarArgsFor(args);
			CoerceAll(actual);
			return actual;
		}

		private Array VarArgsFor(object[] args)
		{
			int count = args.Length - _minimumArgumentCount;
			Array varArgs = Array.CreateInstance(_varArgsParameterType, count);
			for (int i = 0; i<count; ++i)
			{
				int index = _minimumArgumentCount + i;
				args[index] = RuntimeServices.Coerce(args[index], _varArgsParameterType);
			}
			Array.Copy(args, _minimumArgumentCount, varArgs, 0, count);
			return varArgs;
		}
	}
}