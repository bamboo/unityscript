
namespace UnityScript.Tests

import NUnit.Framework
	
[TestFixture]
class DuckyIntegrationTestFixture(AbstractIntegrationTestFixture):
	override def SetCompilationOptions():
		super()
		Parameters.Strict = false

	
	[Test] def JSCheckFloatToIntOverflow():
		RunTestCase("tests/integration/JSCheckFloatToIntOverflow.js")
		
	
	[Test] def JSChooseOverload():
		RunTestCase("tests/integration/JSChooseOverload.js")
		
	
	[Test] def accessor_2():
		RunTestCase("tests/integration/accessor-2.js")
		
	
	[Test] def accessor_3_duck():
		RunTestCase("tests/integration/accessor-3-duck.js")
		
	
	[Test] def accessor():
		RunTestCase("tests/integration/accessor.js")
		
	
	[Test] def anonymous_function_type_1():
		RunTestCase("tests/integration/anonymous-function-type-1.js")
		
	
	[Test] def anonymous_function_type_2():
		RunTestCase("tests/integration/anonymous-function-type-2.js")
		
	
	[Test] def anonymous_function_type_3():
		RunTestCase("tests/integration/anonymous-function-type-3.js")
		
	
	[Test] def array_Add():
		RunTestCase("tests/integration/array-Add.js")
		
	
	[Test] def array_Remove():
		RunTestCase("tests/integration/array-Remove.js")
		
	
	[Test] def array_cast():
		RunTestCase("tests/integration/array-cast.js")
		
	
	[Test] def array_comprehension_1():
		RunTestCase("tests/integration/array-comprehension-1.js")
		
	
	[Test] def array_concat_1():
		RunTestCase("tests/integration/array-concat-1.js")
		
	
	[Test] def array_concat_2():
		RunTestCase("tests/integration/array-concat-2.js")
		
	
	[Test] def array_create():
		RunTestCase("tests/integration/array-create.js")
		
	
	[Test] def array_ctor_with_single_null_element():
		RunTestCase("tests/integration/array-ctor-with-single-null-element.js")
		
	
	[Test] def array_implicit_from_null_enumerable():
		RunTestCase("tests/integration/array-implicit-from-null-enumerable.js")
		
	
	[Test] def array_implicit_from_null():
		RunTestCase("tests/integration/array-implicit-from-null.js")
		
	
	[Test] def array_initializer_in_static_field():
		RunTestCase("tests/integration/array-initializer-in-static-field.js")
		
	
	[Test] def array_instantiation_with_object_argument_in_strict_mode():
		RunTestCase("tests/integration/array-instantiation-with-object-argument-in-strict-mode.js")
		
	
	[Test] def array_instantiation_with_object_argument():
		RunTestCase("tests/integration/array-instantiation-with-object-argument.js")
		
	
	[Test] def array_iteration_with_nulls():
		RunTestCase("tests/integration/array-iteration-with-nulls.js")
		
	
	[Test] def array_join():
		RunTestCase("tests/integration/array-join.js")
		
	
	[Test] def array_length_duck_typed():
		RunTestCase("tests/integration/array-length-duck-typed.js")
		
	
	[Test] def array_nesting():
		RunTestCase("tests/integration/array-nesting.js")
		
	
	[Test] def array_pop():
		RunTestCase("tests/integration/array-pop.js")
		
	
	[Test] def array_push_2():
		RunTestCase("tests/integration/array-push-2.js")
		
	
	[Test] def array_push():
		RunTestCase("tests/integration/array-push.js")
		
	
	[Test] def array_shift():
		RunTestCase("tests/integration/array-shift.js")
		
	
	[Test] def array_slice():
		RunTestCase("tests/integration/array-slice.js")
		
	
	[Test] def array_sort():
		RunTestCase("tests/integration/array-sort.js")
		
	
	[Test] def array_splice_2():
		RunTestCase("tests/integration/array-splice-2.js")
		
	
	[Test] def array_splice():
		RunTestCase("tests/integration/array-splice.js")
		
	
	[Test] def array_str():
		RunTestCase("tests/integration/array-str.js")
		
	
	[Test] def array_toString():
		RunTestCase("tests/integration/array-toString.js")
		
	
	[Test] def array_unshift():
		RunTestCase("tests/integration/array-unshift.js")
		
	
	[Test] def array_with_initial_length():
		RunTestCase("tests/integration/array-with-initial-length.js")
		
	
	[Test] def array_with_two_dimensions():
		RunTestCase("tests/integration/array-with-two-dimensions.js")
		
	
	[Test] def arrays_2():
		RunTestCase("tests/integration/arrays-2.js")
		
	
	[Test] def arrays_3():
		RunTestCase("tests/integration/arrays-3.js")
		
	
	[Test] def arrays_4():
		RunTestCase("tests/integration/arrays-4.js")
		
	
	[Test] def arrays_6():
		RunTestCase("tests/integration/arrays-6.js")
		
	
	[Test] def arrays():
		RunTestCase("tests/integration/arrays.js")
		
	
	[Test] def assign_iterator():
		RunTestCase("tests/integration/assign_iterator.js")
		
	
	[Test] def attributes_2():
		RunTestCase("tests/integration/attributes-2.js")
		
	
	[Test] def attributes():
		RunTestCase("tests/integration/attributes.js")
		
	
	[Test] def auto_coroutine_2():
		RunTestCase("tests/integration/auto-coroutine-2.js")
		
	
	[Test] def auto_coroutine_return_2():
		RunTestCase("tests/integration/auto-coroutine-return-2.js")
		
	
	[Test] def cast_operator_1():
		RunTestCase("tests/integration/cast-operator-1.js")
		
	
	[Test] def cast_operator_precedence():
		RunTestCase("tests/integration/cast-operator-precedence.js")
		
	
	[Test] def chars():
		RunTestCase("tests/integration/chars.js")
		
	
	[Test] def comma_parsing():
		RunTestCase("tests/integration/comma-parsing.js")
		
	
	[Test] def constructor_1():
		RunTestCase("tests/integration/constructor-1.js")
		
	
	[Test] def constructor_2():
		RunTestCase("tests/integration/constructor_2.js")
		
	
	[Test] def continue_issue():
		RunTestCase("tests/integration/continue-issue.js")
		
	
	[Test] def coroutine_2():
		RunTestCase("tests/integration/coroutine-2.js")
		
	
	[Test] def coroutine_3():
		RunTestCase("tests/integration/coroutine-3.js")
		
	
	[Test] def coroutine_4():
		RunTestCase("tests/integration/coroutine-4.js")
		
	
	[Test] def coroutine_5():
		RunTestCase("tests/integration/coroutine-5.js")
		
	
	[Test] def coroutine_return_type_1():
		RunTestCase("tests/integration/coroutine-return-type-1.js")
		
	
	[Test] def coroutine_try_catch():
		RunTestCase("tests/integration/coroutine-try-catch.js")
		
	
	[Test] def coroutine():
		RunTestCase("tests/integration/coroutine.js")
		
	
	[Test] def crash():
		RunTestCase("tests/integration/crash.js")
		
	
	[Test] def do_while():
		RunTestCase("tests/integration/do-while.js")
		
	
	[Test] def double_precision_can_be_used_for_literals():
		RunTestCase("tests/integration/double-precision-can-be-used-for-literals.js")
		
	
	[Test] def empty_array_literal_as_return_value():
		RunTestCase("tests/integration/empty-array-literal-as-return-value.js")
		
	
	[Test] def empty_array_literal_as_yield_value():
		RunTestCase("tests/integration/empty-array-literal-as-yield-value.js")
		
	
	[Test] def empty_string_array():
		RunTestCase("tests/integration/empty-string-array.js")
		
	
	[Test] def enum_1():
		RunTestCase("tests/integration/enum-1.js")
		
	
	[Test] def enum_2():
		RunTestCase("tests/integration/enum-2.js")
		
	
	[Test] def enum_3():
		RunTestCase("tests/integration/enum-3.js")
		
	
	[Test] def enum_4():
		RunTestCase("tests/integration/enum-4.js")
		
	
	[Test] def enum_5():
		RunTestCase("tests/integration/enum-5.js")
		
	
	[Test] def enum_conversion():
		RunTestCase("tests/integration/enum-conversion.js")
		
	
	[Test] def enumerator_array():
		RunTestCase("tests/integration/enumerator-array.js")
		
	
	[Test] def explicit_awake_function():
		RunTestCase("tests/integration/explicit-awake-function.js")
		
	
	[Test] def float_1():
		RunTestCase("tests/integration/float-1.js")
		
	
	[Test] def float_2():
		RunTestCase("tests/integration/float-2.js")
		
	
	[Test] def float_array_literal():
		RunTestCase("tests/integration/float-array-literal.js")
		
	
	[Test] def float_overload_is_preferred_over_int_for_double_argument_2():
		RunTestCase("tests/integration/float-overload-is-preferred-over-int-for-double-argument-2.js")
		
	
	[Test] def float_overload_is_preferred_over_int_for_double_argument_strict_downcast():
		RunTestCase("tests/integration/float-overload-is-preferred-over-int-for-double-argument-strict-downcast.js")
		
	
	[Test] def float_overload_is_preferred_over_int_for_double_argument_strict():
		RunTestCase("tests/integration/float-overload-is-preferred-over-int-for-double-argument-strict.js")
		
	
	[Test] def float_overload_is_preferred_over_int_for_double_argument():
		RunTestCase("tests/integration/float-overload-is-preferred-over-int-for-double-argument.js")
		
	
	[Test] def for_break_1():
		RunTestCase("tests/integration/for-break-1.js")
		
	
	[Test] def for_continue_1():
		RunTestCase("tests/integration/for-continue-1.js")
		
	
	[Test] def for_continue_2():
		RunTestCase("tests/integration/for-continue-2.js")
		
	
	[Test] def for_over_null():
		RunTestCase("tests/integration/for-over-null.js")
		
	
	[Test] def for_var_reuse():
		RunTestCase("tests/integration/for-var-reuse.js")
		
	
	[Test] def functions_1():
		RunTestCase("tests/integration/functions-1.js")
		
	
	[Test] def generator_inheritance_calling_super():
		RunTestCase("tests/integration/generator-inheritance-calling-super.js")
		
	
	[Test] def generator_inheritance_yielding_super():
		RunTestCase("tests/integration/generator-inheritance-yielding-super.js")
		
	
	[Test] def generator_inheritance():
		RunTestCase("tests/integration/generator-inheritance.js")
		
	
	[Test] def implicit_array_to_native_array_cast():
		RunTestCase("tests/integration/implicit-array-to-native-array-cast.js")
		
	
	[Test] def implict_bool_hierarchy():
		RunTestCase("tests/integration/implict-bool-hierarchy.js")
		
	
	[Test] def inferred_GetComponent():
		RunTestCase("tests/integration/inferred-GetComponent.js")
		
	
	[Test] def initializeorder():
		RunTestCase("tests/integration/initializeorder.js")
		
	
	[Test] def interface_properties():
		RunTestCase("tests/integration/interface-properties.js")
		
	
	[Test] def interfaces_1():
		RunTestCase("tests/integration/interfaces-1.js")
		
	
	[Test] def internal_field():
		RunTestCase("tests/integration/internal-field.js")
		
	
	[Test] def invalidil():
		RunTestCase("tests/integration/invalidil.js")
		
	
	[Test] def length_string():
		RunTestCase("tests/integration/length-string.js")
		
	
	[Test] def linq_array_ToList():
		RunTestCase("tests/integration/linq-array-ToList.js")
		
	
	[Test] def linq_function_inference():
		RunTestCase("tests/integration/linq-function-inference.js")
		
	
	[Test] def linq_lambda_inference():
		RunTestCase("tests/integration/linq-lambda-inference.js")
		
	
	[Test] def magicclass():
		RunTestCase("tests/integration/magicclass.js")
		
	
	[Test] def magicconstructor():
		RunTestCase("tests/integration/magicconstructor.js")
		
	
	[Test] def magicconstructor_2():
		RunTestCase("tests/integration/magicconstructor_2.js")
		
	
	[Test] def multidimensional_array_of_struct():
		RunTestCase("tests/integration/multidimensional-array-of-struct.js")
		
	
	[Test] def multidimensional_arrays_1():
		RunTestCase("tests/integration/multidimensional-arrays-1.js")
		
	
	[Test] def nested_class_1():
		RunTestCase("tests/integration/nested-class-1.js")
		
	
	[Test] def nested_classes():
		RunTestCase("tests/integration/nested-classes.js")
		
	
	[Test] def new_1():
		RunTestCase("tests/integration/new-1.js")
		
	
	[Test] def not_in():
		RunTestCase("tests/integration/not-in.js")
		
	
	[Test] def null_initializer():
		RunTestCase("tests/integration/null-initializer.js")
		
	
	[Test] def operators_4():
		RunTestCase("tests/integration/operators-4.js")
		
	
	[Test] def operators_5():
		RunTestCase("tests/integration/operators-5.js")
		
	
	[Test] def override_1():
		RunTestCase("tests/integration/override-1.js")
		
	
	[Test] def param_test():
		RunTestCase("tests/integration/param_test.js")
		
	
	[Test] def parse_int():
		RunTestCase("tests/integration/parse_int.js")
		
	
	[Test] def private_duck():
		RunTestCase("tests/integration/private-duck.js")
		
	
	[Test] def properties():
		RunTestCase("tests/integration/properties.js")
		
	
	[Test] def quack_fu():
		RunTestCase("tests/integration/quack-fu.js")
		
	
	[Test] def question_mark():
		RunTestCase("tests/integration/question_mark.js")
		
	
	[Test] def raw_array_indexing():
		RunTestCase("tests/integration/raw-array-indexing.js")
		
	
	[Test] def rethrow():
		RunTestCase("tests/integration/rethrow.js")
		
	
	[Test] def script_attributes():
		RunTestCase("tests/integration/script-attributes.js")
		
	
	[Test] def script_properties():
		RunTestCase("tests/integration/script-properties.js")
		
	
	[Test] def shift_left_bitwise_or():
		RunTestCase("tests/integration/shift-left-bitwise-or.js")
		
	
	[Test] def static_instance_overload_resolution():
		RunTestCase("tests/integration/static-instance-overload-resolution.js")
		
	
	[Test] def string_append():
		RunTestCase("tests/integration/string-append.js")
		
	
	[Test] def string_concat():
		RunTestCase("tests/integration/string-concat.js")
		
	
	[Test] def switch_3():
		RunTestCase("tests/integration/switch-3.js")
		
	
	[Test] def switch_fallthrough():
		RunTestCase("tests/integration/switch-fallthrough.js")
		
	
	[Test] def switch_simple_2():
		RunTestCase("tests/integration/switch-simple-2.js")
		
	
	[Test] def switch_simple():
		RunTestCase("tests/integration/switch-simple.js")
		
	
	[Test] def switch_with_loop():
		RunTestCase("tests/integration/switch-with-loop.js")
		
	
	[Test] def switch():
		RunTestCase("tests/integration/switch.js")
		
	
	[Test] def transform_collider_bounds():
		RunTestCase("tests/integration/transform-collider-bounds.js")
		
	
	[Test] def typecast_1():
		RunTestCase("tests/integration/typecast-1.js")
		
	
	[Test] def typeof_1():
		RunTestCase("tests/integration/typeof-1.js")
		
	
	[Test] def typeof_2():
		RunTestCase("tests/integration/typeof-2.js")
		
	
	[Test] def types_1():
		RunTestCase("tests/integration/types-1.js")
		
	
	[Test] def uint_1():
		RunTestCase("tests/integration/uint-1.js")
		
	
	[Test] def ulong_bitshift_1():
		RunTestCase("tests/integration/ulong-bitshift-1.js")
		
	
	[Test] def ulong_bitshift_overflow_regression():
		RunTestCase("tests/integration/ulong-bitshift-overflow-regression.js")
		
	
	[Test] def value_types_1():
		RunTestCase("tests/integration/value-types-1.js")
		
	
	[Test] def valuetypes_1():
		RunTestCase("tests/integration/valuetypes-1.js")
		
	
	[Test] def varargs_in_constructor_with_vector3():
		RunTestCase("tests/integration/varargs-in-constructor-with-vector3.js")
		
	
	[Test] def varargs_with_vector3():
		RunTestCase("tests/integration/varargs-with-vector3.js")
		
	
	[Test] def variable_declaration_2():
		RunTestCase("tests/integration/variable-declaration-2.js")
		
	
	[Test] def variable_declaration():
		RunTestCase("tests/integration/variable-declaration.js")
		
	
	[Test] def variables():
		RunTestCase("tests/integration/variables.js")
		
	
	[Test] def vars_1():
		RunTestCase("tests/integration/vars-1.js")
		
	
	[Test] def Array_cast_to_native_array_of_struct():
		RunTestCase("tests/ducky/Array-cast-to-native-array-of-struct.js")
		
	
	[Test] def Array_length():
		RunTestCase("tests/ducky/Array-length.js")
		
	
	[Test] def Array_of_struct_with_struct_loop_update_as_duck():
		RunTestCase("tests/ducky/Array-of-struct-with-struct-loop-update-as-duck.js")
		
	
	[Test] def Array_of_struct_with_struct_loop_update():
		RunTestCase("tests/ducky/Array-of-struct-with-struct-loop-update.js")
		
	
	[Test] def accessor_2_duck():
		RunTestCase("tests/ducky/accessor-2-duck.js")
		
	
	[Test] def accessor_duck():
		RunTestCase("tests/ducky/accessor-duck.js")
		
	
	[Test] def ambigous_call():
		RunTestCase("tests/ducky/ambigous-call.js")
		
	
	[Test] def array_access():
		RunTestCase("tests/ducky/array-access.js")
		
	
	[Test] def array_cast_2():
		RunTestCase("tests/ducky/array-cast-2.js")
		
	
	[Test] def array_cast_3():
		RunTestCase("tests/ducky/array-cast-3.js")
		
	
	[Test] def array_cast_4():
		RunTestCase("tests/ducky/array-cast-4.js")
		
	
	[Test] def array_cast_5():
		RunTestCase("tests/ducky/array-cast-5.js")
		
	
	[Test] def array_iterate():
		RunTestCase("tests/ducky/array-iterate.js")
		
	
	[Test] def array_nest_1():
		RunTestCase("tests/ducky/array-nest-1.js")
		
	
	[Test] def array_nest_2():
		RunTestCase("tests/ducky/array-nest-2.js")
		
	
	[Test] def array_polymorphic_foreach():
		RunTestCase("tests/ducky/array-polymorphic-foreach.js")
		
	
	[Test] def array_push_typesjs():
		RunTestCase("tests/ducky/array-push-typesjs.js")
		
	
	[Test] def auto_coroutine_2_duck():
		RunTestCase("tests/ducky/auto-coroutine-2-duck.js")
		
	
	[Test] def auto_coroutine_duck():
		RunTestCase("tests/ducky/auto-coroutine-duck.js")
		
	
	[Test] def auto_coroutine():
		RunTestCase("tests/ducky/auto-coroutine.js")
		
	
	[Test] def boolcast():
		RunTestCase("tests/ducky/boolcast.js")
		
	
	[Test] def coroutine_return():
		RunTestCase("tests/ducky/coroutine-return.js")
		
	
	[Test] def duck_1():
		RunTestCase("tests/ducky/duck-1.js")
		
	
	[Test] def duck_equality_operator_1():
		RunTestCase("tests/ducky/duck-equality-operator-1.js")
		
	
	[Test] def duck_implicit_bool_1():
		RunTestCase("tests/ducky/duck-implicit-bool-1.js")
		
	
	[Test] def duck_implicit_bool_and_with_simple_ref():
		RunTestCase("tests/ducky/duck-implicit-bool-and-with-simple-ref.js")
		
	
	[Test] def duck_implicit_bool_and():
		RunTestCase("tests/ducky/duck-implicit-bool-and.js")
		
	
	[Test] def duck_implicit_bool_full():
		RunTestCase("tests/ducky/duck-implicit-bool-full.js")
		
	
	[Test] def duck_implicit_bool_simple():
		RunTestCase("tests/ducky/duck-implicit-bool-simple.js")
		
	
	[Test] def duck_negation():
		RunTestCase("tests/ducky/duck-negation.js")
		
	
	[Test] def duck_return_property():
		RunTestCase("tests/ducky/duck-return-property.js")
		
	
	[Test] def duck():
		RunTestCase("tests/ducky/duck.js")
		
	
	[Test] def ducktyped_1():
		RunTestCase("tests/ducky/ducktyped-1.js")
		
	
	[Test] def ducktyping_2():
		RunTestCase("tests/ducky/ducktyping-2.js")
		
	
	[Test] def ducktyping_3():
		RunTestCase("tests/ducky/ducktyping-3.js")
		
	
	[Test] def ducktyping():
		RunTestCase("tests/ducky/ducktyping.js")
		
	
	[Test] def ducky_1():
		RunTestCase("tests/ducky/ducky-1.js")
		
	
	[Test] def ducky_2():
		RunTestCase("tests/ducky/ducky_2.js")
		
	
	[Test] def ducky_3():
		RunTestCase("tests/ducky/ducky_3.js")
		
	
	[Test] def ducky_4():
		RunTestCase("tests/ducky/ducky_4.js")
		
	
	[Test] def ducky_5():
		RunTestCase("tests/ducky/ducky_5.js")
		
	
	[Test] def ducky_6():
		RunTestCase("tests/ducky/ducky_6.js")
		
	
	[Test] def implicit_conversion():
		RunTestCase("tests/ducky/implicit-conversion.js")
		
	
	[Test] def native_array_of_struct_with_struct_loop_update_as_duck():
		RunTestCase("tests/ducky/native-array-of-struct-with-struct-loop-update-as-duck.js")
		
	
	[Test] def native_array_to_Array_as_duck():
		RunTestCase("tests/ducky/native-array-to-Array-as-duck.js")
		
	
	[Test] def null_assign():
		RunTestCase("tests/ducky/null-assign.js")
		
	
	[Test] def var_with_no_initializer():
		RunTestCase("tests/ducky/var-with-no-initializer.js")
		
	
	[Test] def virtual_test():
		RunTestCase("tests/ducky/virtual-test.js")
		