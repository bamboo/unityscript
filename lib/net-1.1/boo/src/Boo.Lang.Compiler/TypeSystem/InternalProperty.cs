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
	using Boo.Lang.Compiler.Ast;

	public class InternalProperty : InternalEntity, IProperty
	{
		private TypeSystemServices _typeSystemServices;
		
		private IParameter[] _parameters;
		
		private IProperty _override;

		private NullableBool _isBooExtension;

		public InternalProperty(TypeSystemServices typeSystemServices, Property property) : base(property)
		{
			_typeSystemServices = typeSystemServices;
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
					_isBooExtension = IsAttributeDefined(Types.BooExtensionAttribute);
				}
				return _isBooExtension.Value;
			}
		}

		private bool IsAttributeDefined(System.Type attributeType)
		{
			return MetadataUtil.IsAttributeDefined(_node, _typeSystemServices.Map(attributeType));
		}
		
		override public EntityType EntityType
		{
			get
			{
				return EntityType.Property;
			}
		}
		
		public IType Type
		{
			get
			{
				return null != Property.Type 
					? TypeSystemServices.GetType(Property.Type)
					: Unknown.Default;
			}
		}

		public bool AcceptVarArgs
		{
			get
			{
				return false;
			}
		}
		
		public IParameter[] GetParameters()
		{
			if (null == _parameters)
			{
				_parameters = _typeSystemServices.Map(Property.Parameters);				
			}
			return _parameters;
		}
		
		public IProperty Override
		{
			get
			{
				return _override;
			}
			
			set
			{
				_override = value;
			}
		}

		public IMethod GetGetMethod()
		{
			if (null != Property.Getter)
			{
				return (IMethod)TypeSystemServices.GetEntity(Property.Getter);
			}
			if (null != _override)
			{
				return _override.GetGetMethod();
			}
			return null;
		}
		
		public IMethod GetSetMethod()
		{
			if (null != Property.Setter)
			{
				return (IMethod)TypeSystemServices.GetEntity(Property.Setter);
			}
			if (null != _override)
			{
				return _override.GetSetMethod();
			}
			return null;
		}

		public Property Property
		{
			get
			{
				return (Property)_node;
			}
		}
		
		override public string ToString()
		{
			return string.Format("{0} as {1}", Name, Type);
		}

		public bool IsDuckTyped
		{
			get
			{
				return this.Type == _typeSystemServices.DuckType 
				|| Property.Attributes.Contains("Boo.Lang.DuckTypedAttribute");
			}
		}
	}
}
