package org.compaction.condition {
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.compaction.InvocationRecorder;
	
	public class AndConditionTest extends TestCase {
		public function testCurrentValueIsTrueIfBothConditionsAreTrue(): void {
			var one:Condition = new Condition(true);
			var two:Condition = new Condition(true);
			assertEquals(true, new AndCondition(one, two).currentValue);
		}
		public function testCurrentValueIsFalseIfFirstConditionIsFalse(): void {
			var one:Condition = new Condition(false);
			var two:Condition = new Condition(true);
			assertEquals(false, new AndCondition(one, two).currentValue);
		}
		public function testCurrentValueIsFalseIfSecondConditionIsFalse(): void {
			var one:Condition = new Condition(true);
			var two:Condition = new Condition(false);
			assertEquals(false, new AndCondition(one, two).currentValue);			
		}
		public function testCurrentMessageIsSameAsFirstConditionIfBothHaveMessages(): void {
			var one:Condition = new Condition(true, "first");
			var two:Condition = new Condition(true, "second");
			assertEquals("first", new AndCondition(one, two).currentMessage);
		}
		public function testCurrentMessageIsSameAsFirstCondition(): void {
			var one:Condition = new Condition(true, "first");
			var two:Condition = new Condition(true);
			assertEquals("first", new AndCondition(one, two).currentMessage);
		}
		public function testCurrentMessageIsSameAsSecondCondition(): void {
			var one:Condition = new Condition(true);
			var two:Condition = new Condition(false, "second");
			assertEquals("second", new AndCondition(one, two).currentMessage);
		}
		public function testCurrentValueIsBindable(): void {
			var one:Condition = new Condition(false);
			var two:Condition = new Condition(false);
			var condition:ICondition = new AndCondition(one, two);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentValue", recorder.invocationRecorder);
			one.currentValue = true;
			two.currentValue = true;
			assertEquals(2, recorder.invocationCount);
		}
		public function testCurrentMessageIsBindable(): void {
			var one:Condition = new Condition(false);
			var two:Condition = new Condition(false);
			var condition:ICondition = new AndCondition(one, two);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(condition, "currentMessage", recorder.invocationRecorder);
			one.falseMessage = "foo";
			two.falseMessage = "foo";
			assertEquals(2, recorder.invocationCount);
		}
		public function testSetFalseMessageThrowsException(): void {
			try {
				var condition:AndCondition = new AndCondition(null, null);
				condition.falseMessage = "false";
				fail("not condition should be read only.");
			} catch(e:Error) {
				assertEquals("This condition is read only.", e.message);
			} 
		}
		public function testSetTrueMessageThrowsException(): void {
			try {
				var condition:AndCondition = new AndCondition(null, null);
				condition.trueMessage = "true";
				fail("not condition should be read only.");
			} catch(e:Error) {
				assertEquals("This condition is read only.", e.message);
			} 
		}
	}
}