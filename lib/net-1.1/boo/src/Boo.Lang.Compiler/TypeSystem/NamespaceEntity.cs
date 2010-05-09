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
	using System.Collections;
	using System.Reflection;

	public class NamespaceEntity : IEntity, INamespace
	{		
		TypeSystemServices _typeSystemServices;
		
		INamespace _parent;
		
		string _name;

		// Dictionary<Assembly, Dictionary<string, List>> _assemblies;
		Hashtable _assemblies;

		Hashtable _childrenNamespaces;
		
		List _internalModules;
		
		List _externalModules;
		
		public NamespaceEntity(INamespace parent, TypeSystemServices tagManager, string name)
		{			
			_parent = parent;
			_typeSystemServices = tagManager;
			_name = name;			_assemblies = new Hashtable();
			_childrenNamespaces = new Hashtable();
			_internalModules = new List();
			_externalModules = new List();
		}
		
		public string Name
		{
			get
			{
				return GetLastPart(_name);
			}
		}
		
		public string FullName
		{
			get
			{
				return _name;
			}
		}
		
		public EntityType EntityType
		{
			get
			{
				return EntityType.Namespace;
			}
		}
		
		public void Add(Type type)
		{
			string name = TypeUtilities.TypeName(type);

			Hashtable types = TypeListHashtableFor(type.Assembly);
			if (!types.ContainsKey(name))
			{
				types.Add(name, new List());
			}

			((List)types[name]).Add(type);

			if (_typeSystemServices.IsModule(type))
			{
				_externalModules.Add((ExternalType) _typeSystemServices.Map(type));
			}
		}

		private Hashtable TypeListHashtableFor(Assembly assembly)
		{
			string assemblyName = assembly.FullName;
			Hashtable types = ExistingTypeListHashtableFor(assemblyName);
			if (types == null)
			{
				types = new Hashtable();
				_assemblies.Add(assemblyName, types);
			}
			return types;
		}

		private Hashtable ExistingTypeListHashtableFor(string assemblyName)
		{
			return (Hashtable) _assemblies[assemblyName];
		}

		public void AddModule(ModuleEntity module)
		{
			_internalModules.Add(module);
		}
		
		public IEntity[] GetMembers()
		{
			List members = AllTypeEntities();
			members.Extend(_childrenNamespaces.Values);
			return (IEntity[])members.ToArray(typeof(IEntity));
		}

		private List AllTypeEntities()
		{
			List result = new List();
			foreach (Hashtable typeLists in _assemblies.Values)
				foreach (List types in typeLists.Values)
					foreach (Type type in types) 
						result.Add(_typeSystemServices.Map(type));
			return result;
		}
		
		public NamespaceEntity GetChildNamespace(string name)
		{
			NamespaceEntity tag = (NamespaceEntity) _childrenNamespaces[name];
			if (null == tag)
			{				
				tag = new NamespaceEntity(this, _typeSystemServices, _name + "." + name);
				_childrenNamespaces[name] = tag;
			}
			return tag;
		}
		
		internal bool Resolve(List targetList, string name, Assembly assembly, EntityType flags)
		{
			NamespaceEntity entity = ExistingChildNamespace(name);
			if (entity != null)
			{
				targetList.Add(new AssemblyQualifiedNamespaceEntity(assembly, entity));
				return true;
			}

			
			Hashtable types = ExistingTypeListHashtableFor(assembly.FullName);
			if (types == null)
			{
				return false;
			}

			bool found = ResolveType(targetList, name, types);
			foreach (ExternalType external in _externalModules)
			{
				if (external.ActualType.Assembly.FullName == assembly.FullName)
				{
					if (external.Resolve(targetList, name, flags)) found = true;
				}
			}
			return found;
		}

		private NamespaceEntity ExistingChildNamespace(string name)
		{
			return (NamespaceEntity) _childrenNamespaces[name];
		}

		public INamespace ParentNamespace
		{
			get { return _parent; }
		}
		
		public bool Resolve(List targetList, string name, EntityType flags)
		{	
			NamespaceEntity tag = ExistingChildNamespace(name);
			if (null != tag)
			{
				targetList.Add(tag);
				return true;
			}
			
			if (ResolveInternalType(targetList, name, flags)) return true;

			bool found = ResolveExternalType(targetList, name);
			if (ResolveExternalModules(targetList, name, flags)) found = true;
			return found;
		}

		private static bool IsFlagSet(EntityType flags, EntityType flag)
		{
			return flag != (flag & flags);
		}

		bool ResolveInternalType(List targetList, string name, EntityType flags)
		{
			bool found = false;
			foreach (ModuleEntity ns in _internalModules)
			{
				if (ns.ResolveMember(targetList, name, flags)) found = true;
			}
			return found;
		}
		
		bool ResolveExternalType(List targetList, string name)
		{			
			foreach (Hashtable typeLists in _assemblies.Values)
			{
				//we do not use _assemblies.Values to keep fifo ordering
				if (ResolveType(targetList, name, typeLists)) return true;
			}
			return false;
		}

		private bool ResolveType(List targetList, string name, Hashtable types)
		{
			List found = (List) types[name];
			if (found == null) return false;

			foreach (Type type in found)
			{
				targetList.Add(_typeSystemServices.Map(type));
				
				// Can't return right away, since we can have several types
				// with the same name but different number of generic arguments. 
			}
			return true;
		}

		bool ResolveExternalModules(List targetList, string name, EntityType flags)
		{
			bool found = false;
			foreach (ExternalType ns in _externalModules)
			{
				if (ns.Resolve(targetList, name, flags)) found = true;
			}
			return found;
		}
		
		override public string ToString()
		{
			return _name;
		}

		private static string GetLastPart(string name)
		{
			int index = name.LastIndexOf('.');
			return index < 0 ? name : name.Substring(index+1);
		}
	}
}
