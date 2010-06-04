namespace UnityScript.MonoDevelop.Completion

import UnityScript

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Steps
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.TypeSystem

class CompletionFinder(DepthFirstVisitor):

   public static final CompletionToken = "__complete_me__"

   _type as IType

   def FindCompletionTypeFor(node as Node):
       VisitAllowingCancellation(node)
       return _type

   override def LeaveMemberReferenceExpression(node as MemberReferenceExpression):
       if node.Name != CompletionToken:
               return

       Found(node.Target.ExpressionType)

   protected def Found(type):
       _type = type
       Cancel()