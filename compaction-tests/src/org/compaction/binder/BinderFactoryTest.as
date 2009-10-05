package org.compaction.binder {
	import flexunit.framework.TestCase;
	
	public class BinderFactoryTest extends TestCase {
		public function testNewActionBinderCreatesActionBinder(): void {
			assertEquals(true, new BinderFactory().newButtonBinder() is ButtonBinder);
		}
		public function testNewTextBinderCreatesTextBinder(): void {
			assertEquals(true, new BinderFactory().newTextBinder() is TextBinder);
		}
		public function testNewTextAreaBinderCreatesTextAreaBinder(): void {
			assertEquals(true, new BinderFactory().newTextAreaBinder() is TextAreaBinder);
		}
		public function testNewDateBinderCreatesDateBinder(): void {
			assertEquals(true, new BinderFactory().newDateBinder() is DateBinder);
		}
		public function testNewBooleanBinderCreatesBooleanBinder(): void {
			assertEquals(true, new BinderFactory().newBooleanBinder() is BooleanBinder);
		}
		public function testNewComboBinderCreatesComboBinder(): void {
			assertEquals(true, new BinderFactory().newComboBinder() is ComboBinder);
		}
		public function testNewValidationBinderCreatesValidationBinder(): void {
			assertEquals(true, new BinderFactory().newValidationBinder() is ValidationBinder);
		}
		public function testNewConditionBinderCreatesConditionBinder(): void {
			assertEquals(true, new BinderFactory().newConditionBinder() is ConditionBinder);
		}
	}
}