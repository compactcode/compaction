package org.compaction.condition {
	
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.compaction.InvocationRecorder;
	
	public class NotConditionTest extends TestCase {
		public function testCurrentValueIsInversionOfDelegate(): void {
			var delegate:Condition = new Condition(false);
			var condition:NotCondition = new NotCondition(delegate);
			assertEquals(true, condition.currentValue);
		}
		public function testCurrentMessageIsTheSameAsDelegate(): void {
			var delegate:Condition = new Condition(false);
			delegate.falseMessage = "false";
			var condition:NotCondition = new NotCondition(delegate);
			assertEquals("false", condition.currentMessage);
		}
		public function testSetFalseMessageThrowsException(): void {
			try {
				var delegate:Condition = new Condition(false);
				var condition:NotCondition = new NotCondition(delegate);
				condition.falseMessage = "false";
				fail("not condition should be read only.");
			} catch(e:Error) {
				assertEquals("This condition is read only.", e.message);
			} 
		}
		public function testSetTrueMessageThrowsException(): void {
			try {
				var delegate:Condition = new Condition(false);
				var condition:NotCondition = new NotCondition(delegate);
				condition.trueMessage = "true";
				fail("not condition should be read only.");
			} catch(e:Error) {
				assertEquals("This condition is read only.", e.message);
			} 
		}
		public function testCurrentValueIsBindable(): void {
			var delegate:Condition = new Condition(false);
			var condition:ICondition = new NotCondition(delegate);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentValue", recorder.invocationRecorder);
			delegate.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
		public function testCurrentMessageIsBindable(): void {
			var delegate:Condition = new Condition(true);
			var condition:ICondition = new NotCondition(delegate);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentMessage", recorder.invocationRecorder);
			delegate.trueMessage = "foo";
			assertEquals(1, recorder.invocationCount);
		}
	}
}