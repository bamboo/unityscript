${header}
namespace Boo.Lang.Compiler.Ast
{
	using System;
	using Boo.Lang;
	using Boo.Lang.Compiler.Ast;
<%

itemType = "Boo.Lang.Compiler.Ast." + model.GetCollectionItemType(node)
typeName = " ${node.Name}Impl" 

%>	
	[Serializable]
	[EnumeratorItemType(typeof(${itemType}))]
	public class ${typeName} : NodeCollection
	{
		public static ${node.Name} FromArray(params ${itemType}[] items)
		{
			${node.Name} collection = new ${node.Name}();
			collection.Extend(items);
			return collection;
		}
		
		protected ${typeName}()
		{
		}

		protected ${typeName}(Boo.Lang.Compiler.Ast.Node parent) : base(parent)
		{
		}

		public ${itemType}Collection PopRange(int begin)
		{
			${itemType}Collection range = new ${itemType}Collection(_parent);
			range.InnerList.Extend(InternalPopRange(begin));
			return range;
		}
		
		public ${itemType} this[int index]
		{
			get { return (${itemType})InnerList[index]; }
			set { ReplaceNodeAt(index, value); }
		}
		
		public void Add(${itemType} item)
		{
			AddImpl(item);
		}
		
		public void Insert(int index, ${itemType} item)
		{
			InsertImpl(index, item);
		}
		
		public bool Replace(${itemType} existingNode, ${itemType} newNode)
		{
			return ReplaceImpl(existingNode, newNode);
		}
		
		public void ReplaceAt(int index, ${itemType} newNode)
		{
			ReplaceNodeAt(index, newNode);
		}
		
		public ${itemType}[] ToArray()
		{
			return (${itemType}[])ToArray(typeof(${itemType}));
		}
		
		public ${itemType}[] ToReverseArray()
		{
			return (${itemType}[])ToReverseArray(typeof(${itemType}));
		}
	}
}

