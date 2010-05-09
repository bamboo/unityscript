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

using Boo.Lang.Compiler.Util;

namespace Boo.Lang.Compiler.TypeSystem
{
	using System;
	using System.Reflection;

	public class ExternalMethod : ExternalEntity, IMethod
	{
		protected IParameter[] _parameters;
		
		protected ICallableType _type;

		private NullableBool _acceptVarArgs;

		private NullableBool _isBooExtension;

		private NullableBool _isPInvoke;
		private NullableBool _isMeta;

		internal ExternalMethod(TypeSystemServices manager, MethodBase mi) : base(manager, mi)
		{
		}

		public bool IsMeta
		{
			get
			{
				if (!_isMeta.HasValue)
				{
					_isMeta = IsStatic && MetadataUtil.IsAttributeDefined(MethodInfo, typeof(Boo.Lang.MetaAttribute));
				}
				return _isMeta.Value;
			}
		}

		public bool IsExtension
		{
			get
			{
				return IsBooExtension;
			}
		}

		public bool IsBooExtension
		{
			get
			{
				if (!_isBooExtension.HasValue)
				{
					_isBooExtension = MetadataUtil.IsAttributeDefined(MethodInfo, Types.BooExtensionAttribute);
				}
				return _isBooExtension.Value;
			}
		}

		public bool IsPInvoke
		{
			get
			{
				if (!_isPInvoke.HasValue)
				{
					_isPInvoke = IsStatic && MetadataUtil.IsAttributeDefined(MethodInfo,  Types.DllImportAttribute);
				}
				return _isPInvoke.Value;
			}
		}
		
		public virtual IType DeclaringType
		{
			get
			{
				return _typeSystemServices.Map(MethodInfo.DeclaringType);
			}
		}
		
		public bool IsStatic
		{
			get
			{
				return MethodInfo.IsStatic;
			}
		}
		
		public bool IsPublic
		{
			get
			{
				return MethodInfo.IsPublic;
			}
		}
		
		public bool IsProtected
		{
			get
			{
				return MethodInfo.IsFamily || MethodInfo.IsFamilyOrAssembly;
			}
		}

		public bool IsPrivate
		{
			get
			{
				return MethodInfo.IsPrivate;
			}
		}
		
		public bool IsAbstract
		{
			get
			{
				return MethodInfo.IsAbstract;
			}
		}

		public bool IsInternal
		{
			get
			{
				return MethodInfo.IsAssembly;
			}
		}
		
		public bool IsVirtual
		{
			get
			{
				return MethodInfo.IsVirtual;
			}
		}
		
		public bool IsSpecialName
		{
			get
			{
				return MethodInfo.IsSpecialName;
			}
		}
		
		public bool AcceptVarArgs
		{
			get
			{
				if (!_acceptVarArgs.HasValue)
				{
					ParameterInfo[] parameters = MethodInfo.GetParameters();
					_acceptVarArgs =
						parameters.Length > 0 && IsParamArray(parameters[parameters.Length-1]);
				}
				return _acceptVarArgs.Value;
			}
		}

		private bool IsParamArray(ParameterInfo parameter)
		{
			/* Hack to fix problem with mono-1.1.8.* and older */
			return parameter.ParameterType.IsArray
				&& (
					Attribute.IsDefined(parameter, Types.ParamArrayAttribute)
					|| parameter.GetCustomAttributes(Types.ParamArrayAttribute, false).Length > 0);
		}

		
		override public EntityType EntityType
		{
			get
			{
				return EntityType.Method;
			}
		}
		
		public ICallableType CallableType
		{
			get
			{
				if (null != _type) return _type;

                return _type = _typeSystemServices.GetCallableType(this);
			}
		}
		
		public IType Type
		{
			get
			{
				return CallableType;
			}
		}
		
		public virtual IParameter[] GetParameters()
		{
            if (null != _parameters) return _parameters;
            return _parameters = _typeSystemServices.Map(MethodInfo.GetParameters());
		}

		public virtual IType ReturnType
		{
			get
			{
				MethodInfo mi = _memberInfo as MethodInfo;
				if (null != mi) return _typeSystemServices.Map(mi.ReturnType);
				return null;
			}
		}

		public MethodBase MethodInfo
		{
			get { return (MethodBase)_memberInfo; }
		}
		
		override public bool Equals(object other)
		{
			ExternalMethod rhs = other as ExternalMethod;
			if (null == rhs) return false;
			return MethodInfo.MethodHandle.Value == rhs.MethodInfo.MethodHandle.Value;
		}
		
		override public int GetHashCode()
		{
			return MethodInfo.MethodHandle.Value.GetHashCode();
		}
		
		override public string ToString()
		{
			return _typeSystemServices.GetSignature(this);
		}
	
		protected override Type MemberType
		{
			get
			{
				MethodInfo mi = _memberInfo as MethodInfo;
				if (null != mi) return mi.ReturnType;
				return null;
			}
		}
	}
}
