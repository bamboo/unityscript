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

namespace Boo.Lang.Compiler.TypeSystem
{	
	public class ExternalField : ExternalEntity, IField
	{
		public ExternalField(TypeSystemServices typeSystemServices, System.Reflection.FieldInfo field) : base(typeSystemServices, field)
		{	
		}
		
		public virtual IType DeclaringType
		{
			get { return _typeSystemServices.Map(_memberInfo.DeclaringType); }
		}
		
		public bool IsPublic
		{
			get { return FieldInfo.IsPublic; }
		}
		
		public bool IsProtected
		{
			get { return FieldInfo.IsFamily || FieldInfo.IsFamilyOrAssembly; }
		}

		public bool IsPrivate
		{
			get { return FieldInfo.IsPrivate; }
		}

		public bool IsInternal
		{
			get { return FieldInfo.IsAssembly; }
		}
		
		public bool IsStatic
		{
			get { return FieldInfo.IsStatic; }
		}
		
		public bool IsLiteral
		{
			get { return FieldInfo.IsLiteral; }
		}
		
		public bool IsInitOnly
		{
			get { return FieldInfo.IsInitOnly; }
		}
		
		override public EntityType EntityType
		{
			get { return EntityType.Field; }
		}
		
		public virtual IType Type
		{
			get { return _typeSystemServices.Map(FieldInfo.FieldType); }
		}
		
		public object StaticValue
		{
			get { return FieldInfo.GetValue(null); }
		}
		
		public System.Reflection.FieldInfo FieldInfo
		{
			get { return (System.Reflection.FieldInfo)_memberInfo; }
		}
		
		protected override Type MemberType
		{
			get { return FieldInfo.FieldType; }
		}
	}
}
