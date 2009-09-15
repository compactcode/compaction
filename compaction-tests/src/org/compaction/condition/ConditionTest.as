package org.compaction.condition {
	
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.compaction.InvocationRecorder;
	
	public class ConditionTest extends TestCase {
		public function testValueDefaultsToValueAssignedOnCreation(): void {
			assertEquals(false, new Condition(false).currentValue);
			assertEquals(true, new Condition(true).currentValue);
		}
		public function testCurrentMessageIsFalseMessageWhenFalse(): void {
			var condition:Condition = new Condition(false);
			condition.falseMessage = "false";
			assertEquals("false", condition.currentMessage);
		}
		public function testCurrentMessageIsTrueMessageWhenTrue(): void {
			var condition:Condition = new Condition(true);
			condition.trueMessage = "true";
			assertEquals("true", condition.currentMessage);
		}
		public function testCurrentValueIsBindable(): void {
			var condition:Condition = new Condition(false);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentValue", recorder.invocationRecorder);
			condition.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
		public function testCurrentMessageIsBindable(): void {
			var condition:Condition = new Condition(false);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentMessage", recorder.invocationRecorder);
			condition.trueMessage = "true";
			condition.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
	}
}