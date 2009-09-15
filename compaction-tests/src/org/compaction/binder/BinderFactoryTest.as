package org.compaction.binder {
	import flexunit.framework.TestCase;
	
	public class BinderFactoryTest extends TestCase {
		public function testNewActionBinderCreatesActionBinder(): void {
			assertEquals(true, new BinderFactory().newActionBinder() is ActionBinder);
		}
		public function testNewTextBinderCreatesTextBinder(): void {
			assertEquals(true, new BinderFactory().newTextBinder() is TextBinder);
		}
		public function testNewDateBinderCreatesDateBinder(): void {
			assertEquals(true, new BinderFactory().newDateBinder() is DateBinder);
		}
	}
}