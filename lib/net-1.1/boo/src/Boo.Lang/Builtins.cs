#region license
// Copyright (c) 2004, Rodrigo B. de Oliveira (rbo@acm.org)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//     * Neither the name of Rodrigo B. de Oliveira nor the names of its
//     contributors may be used to endorse or promote products derived from this
//     software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#endregion

using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Reflection;
using Boo.Lang.Runtime;

namespace Boo.Lang
{
	/// <summary>
	/// boo language builtin functions.
	/// </summary>
	public class Builtins
	{
		public class duck
		{
		}

		public static System.Version BooVersion
		{
			get
			{
				return new System.Version("0.8.2.3021");
			}
		}

		public static void print(object o)
		{
			Console.WriteLine(o);
		}

		public static string gets()
		{
			return Console.ReadLine();
		}

		public static string prompt(string message)
		{
			Console.Write(message);
			return Console.ReadLine();
		}

		public static IEnumerable map(object enumerable, ICallable callable)
		{
			return new MapEnumerable(iterator(enumerable), callable);
		}

		private class MapEnumerable : IEnumerable
		{
			private IEnumerable _enumerable;
			private ICallable _callable;

			public MapEnumerable(IEnumerable enumerable, ICallable callable)
			{
				_enumerable = enumerable;
				_callable = callable;
			}

			public IEnumerator GetEnumerator()
			{
				return new Enumerator(_enumerable.GetEnumerator(), _callable);
			}

			private class Enumerator : IEnumerator
			{
				private IEnumerator _enumerator;
				private ICallable _callable;
				private object _current;

				public Enumerator(IEnumerator enumerator, ICallable callable)
				{
					_enumerator = enumerator;
					_callable = callable;
					_current = null;
				}
				#region IEnumerator Members

				public void Reset()
				{
					_enumerator.Reset();
					_current = null;
				}

				public object Current
				{
					get { return _current; }
				}

				public bool MoveNext()
				{
					if (_enumerator.MoveNext())
					{
						_current = _callable.Call(new object[] {_enumerator.Current});
						return true;
					}
					return false;
				}

				#endregion
			}
		}

		public static string join(IEnumerable enumerable, string separator)
		{
			StringBuilder sb = new StringBuilder();
			IEnumerator enumerator = enumerable.GetEnumerator();
			using (enumerator as IDisposable)
			{
				if (enumerator.MoveNext())
				{
					sb.Append(enumerator.Current);
					while (enumerator.MoveNext())
					{
						sb.Append(separator);
						sb.Append(enumerator.Current);
					}
				}
			}
			return sb.ToString();
		}

		public static string join(IEnumerable enumerable, char separator)
		{
			StringBuilder sb = new StringBuilder();
			IEnumerator enumerator = enumerable.GetEnumerator();
			using (enumerator as IDisposable)
			{
				if (enumerator.MoveNext())
				{
					sb.Append(enumerator.Current);
					while (enumerator.MoveNext())
					{
						sb.Append(separator);
						sb.Append(enumerator.Current);
					}
				}
			}
			return sb.ToString();
		}

		public static string join(IEnumerable enumerable)
		{
			return join(enumerable, ' ');
		}

		public static object[] array(IEnumerable enumerable)
		{
			return new List(enumerable).ToArray();
		}

		public static Array array(Type elementType, ICollection collection)
		{
			if (null == collection)
			{
				throw new ArgumentNullException("collection");
			}
			if (null == elementType)
			{
				throw new ArgumentNullException("elementType");
			}

			Array array = Array.CreateInstance(elementType, collection.Count);
			if (RuntimeServices.IsPromotableNumeric(Type.GetTypeCode(elementType)))
			{
				int i=0;
				foreach (object item in collection)
				{
					object value = RuntimeServices.CheckNumericPromotion(item).ToType(elementType, null);
					array.SetValue(value, i);
					++i;
				}
			}
			else
			{
				collection.CopyTo(array, 0);
			}
			return array;
		}

		public static Array array(Type elementType, IEnumerable enumerable)
		{
			if (null == enumerable)
			{
				throw new ArgumentNullException("enumerable");
			}
			if (null == elementType)
			{
				throw new ArgumentNullException("elementType");
			}

			// future optimization, check EnumeratorItemType of enumerable
			// and get the fast path whenever possible
			List l = null;
			if (RuntimeServices.IsPromotableNumeric(Type.GetTypeCode(elementType)))
			{
				l = new List();
				foreach (object item in enumerable)
				{
					object value = RuntimeServices.CheckNumericPromotion(item).ToType(elementType, null);
					l.Add(value);
				}
			}
			else
			{
				l = new List(enumerable);
			}
			return l.ToArray(elementType);
		}

		public static Array array(Type elementType, int length)
		{
			return matrix(elementType, length);
		}

		public static Array matrix(Type elementType, params int[] lengths)
		{
			if (null == elementType)
			{
				throw new ArgumentNullException("elementType");
			}
			return Array.CreateInstance(elementType, lengths);
		}

		public static IEnumerable iterator(object enumerable)
		{
			return RuntimeServices.GetEnumerable(enumerable);
		}

#if !NO_SYSTEM_DLL
		public static System.Diagnostics.Process shellp(string filename, string arguments)
		{
            System.Diagnostics.Process p = new System.Diagnostics.Process();
			p.StartInfo.Arguments = arguments;
			p.StartInfo.CreateNoWindow = true;
			p.StartInfo.UseShellExecute = false;
			p.StartInfo.RedirectStandardOutput = true;
			p.StartInfo.RedirectStandardInput = true;
			p.StartInfo.RedirectStandardError = true;
			p.StartInfo.FileName = filename;
			p.Start();
			return p;
		}

		public static string shell(string filename, string arguments)
		{
            System.Diagnostics.Process p = shellp(filename, arguments);
			string output = p.StandardOutput.ReadToEnd();
			p.WaitForExit();
			return output;
		}
#endif

		internal class AssemblyExecutor : MarshalByRefObject
		{
			string _filename;
			string[] _arguments;
			string _capturedOutput = "";

			public AssemblyExecutor(string filename, string[] arguments)
			{
				_filename = filename;
				_arguments = arguments;
			}

			public string CapturedOutput
			{
				get
				{
					return _capturedOutput;
				}
			}

			public void Execute()
			{
				StringWriter output = new System.IO.StringWriter();
				TextWriter saved = Console.Out;
				try
				{
					Console.SetOut(output);
					//AppDomain.CurrentDomain.ExecuteAssembly(_filename, null, _arguments);
					Assembly.LoadFrom(_filename).EntryPoint.Invoke(null, new object[1] { _arguments });
				}
				finally
				{
					Console.SetOut(saved);
					_capturedOutput = output.ToString();
				}
			}
		}

		/// <summary>
		/// Execute the specified MANAGED application in a new AppDomain.
		///
		/// The base directory for the new application domain will be set to
		/// directory containing filename (Path.GetDirectoryName(Path.GetFullPath(filename))).
		/// </summary>
		public static string shellm(string filename, params string[] arguments)
		{
			AppDomainSetup setup = new AppDomainSetup();
			setup.ApplicationBase = Path.GetDirectoryName(Path.GetFullPath(filename));

			AppDomain domain = AppDomain.CreateDomain("shellm", null, setup);
			try
			{
				AssemblyExecutor executor = new AssemblyExecutor(filename, arguments);
				domain.DoCallBack(new CrossAppDomainDelegate(executor.Execute));
				return executor.CapturedOutput;
			}
			finally
			{
				AppDomain.Unload(domain);
			}
		}

		public static RangeEnumerable range(int max)
		{
			if (max < 0) /* added for coherence with behavior of compiler-optimized
						  * for-in-range() loops, should compiler loops automatically
						  * inverse iteration in this case? */
			{
				throw new ArgumentOutOfRangeException("max < 0");
			}
			return range(0, max, 1);
		}

		public static RangeEnumerable range(int begin, int end)
		{
			if (begin < end)
			{
				return range(begin, end, 1);
			}
			return range(begin, end, -1);
		}

		public static RangeEnumerable range(int begin, int end, int step)
		{
			if (0 == step)
			{
				throw new ArgumentOutOfRangeException("step == 0");
			}
			if (step < 0)
			{
				if (begin < end)
				{
					throw new ArgumentOutOfRangeException("begin < end && step < 0");
				}
				return new RangeEnumerable(begin, end, step);
			}
			else
			{
				if (begin > end)
				{
					throw new ArgumentOutOfRangeException("begin > end && step > 0");
				}
				return new RangeEnumerable(begin, end, step);
			}
		}

		[EnumeratorItemType(typeof(int))]
		public class RangeEnumerable : IEnumerable
		{
			private readonly int _begin;
			private readonly int _end;
			private readonly int _step;

			internal RangeEnumerable(int begin, int end, int step)
			{
				_begin = begin;
				_end = end;
				_step = step;
			}

			public IEnumerator GetEnumerator()
			{
				return _step > 0 ? new ForwardEnumerator(this) : new ReverseEnumerator(this);
			}

			private class ReverseEnumerator : ForwardEnumerator
			{
				public ReverseEnumerator(RangeEnumerable context) : base(context)
				{
				}

				protected override bool Finished()
				{
					return _next <= _context._end;
				}
			}

			private class ForwardEnumerator : IEnumerator
			{
				protected readonly RangeEnumerable _context;
				private object _current;
				protected int _next;

				public ForwardEnumerator(RangeEnumerable context)
				{
					_context = context;
					_next = context._begin;
				}

				public bool MoveNext()
				{
					if (Finished())
						return false;
					_current = _next;
					_next += _context._step;
					return true;
				}

				protected virtual bool Finished()
				{
					return _next >= _context._end;
				}

				public void Reset()
				{
					throw new NotImplementedException();
				}

				public object Current
				{
					get { return _current; }
				}
			}
		}

		public static IEnumerable reversed(object enumerable)
		{
			return new List(iterator(enumerable)).Reversed;
		}

		public static ZipEnumerator zip(params object[] enumerables)
		{
			return new ZipEnumerator(Enumerators(iterators(enumerables)));
		}

		private static IEnumerator[] Enumerators(IEnumerable[] enumerables)
		{
			IEnumerator[] enumerators = new IEnumerator[enumerables.Length];
			for (int i=0; i<enumerables.Length; ++i)
			{
				enumerators[i] = enumerables[i].GetEnumerator();
			}
			return enumerators;
		}

		private static IEnumerable[] iterators(object[] enumerables)
		{
			IEnumerable[] enumerators = new IEnumerable[enumerables.Length];
			for (int i=0; i<enumerables.Length; ++i)
			{
				enumerators[i] = iterator(enumerables[i]);
			}
			return enumerators;
		}

		public static IEnumerable cat(params object[] args)
		{
			return new CatEnumerator(iterators(args));
		}

		public class CatEnumerator : IEnumerable
		{
			private readonly IEnumerable[] _enumerables;

			public CatEnumerator(IEnumerable[] enumerables)
			{
				_enumerables = enumerables;
			}

			public IEnumerator GetEnumerator()
			{
				return new Enumerator(Enumerators(_enumerables));
			}

			private class Enumerator : MultiEnumeratorBase
			{
				private IEnumerator _iterators;
				private IEnumerator _current;

				public Enumerator(IEnumerator[] enumerators) : base(enumerators)
				{
					_iterators = enumerators.GetEnumerator();
					_current = null;
				}

				public override bool MoveNext()
				{
					while (_current == null || !_current.MoveNext())
					{
						if (!_iterators.MoveNext())
							return false;

						_current = (IEnumerator) _iterators.Current;
					}
					return true;
				}

				public override object Current
				{
					get
					{
						if (null == _current) throw new InvalidOperationException();
						return _current.Current;
					}
				}
			}
		}

		[EnumeratorItemType(typeof(object[]))]
		public class ZipEnumerator : MultiEnumeratorBase, IEnumerable
		{
			internal ZipEnumerator(params IEnumerator[] enumerators) : base(enumerators)
			{
			}

			public override bool MoveNext()
			{
				for (int i=0; i<_enumerators.Length; ++i)
				{
					if (!_enumerators[i].MoveNext())
					{
						return false;
					}
				}
				return true;
			}

			public override object Current
			{
				get
				{
					object[] current = new object[_enumerators.Length];
					for (int i=0; i<current.Length; ++i)
					{
						current[i] = _enumerators[i].Current;
					}
					return current;
				}
			}

			public IEnumerator GetEnumerator()
			{
				return this;
			}
		}
	}
}

