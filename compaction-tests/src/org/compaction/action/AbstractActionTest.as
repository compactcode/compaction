package org.compaction.action {
	
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.compaction.InvocationRecorder;
	import org.compaction.condition.Condition;
	
	public class AbstractActionTest extends TestCase{
		public function testAssertAvailableThrowsErrorIfNotAvailable(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(false));
			try {
				action.assertAvailable();
				fail();
			} catch (e:Error) {
				assertEquals("Action is not available.", e.message);
			}
		}
		
		public function testAvailableDefaultsToTrue(): void {
			assertEquals(true, new AbstractAction().available);
		}
		public function testAvailableTrueConditionSetsActionUnavailableIfConditionIsFalse(): void {
			var action:AbstractAction = new AbstractAction();
			var condition:Condition = new Condition(false);
			action.availableWhenTrue(condition);
			assertEquals(false, action.available);
		}
		public function testAvailableTrueConditionSetsActionAvailableIfConditionIsTrue(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(true));
			assertEquals(true, action.available);
		}
		public function testAvailableTrueConditionsStack(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(false));
			action.availableWhenTrue(new Condition(true));
			assertEquals(false, action.available);
		}
		
		public function testAvailableFalseConditionSetsActionAvailableIfConditionIsFalse(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenFalse(new Condition(false));
			assertEquals(true, action.available);
		}
		public function testAvailableFalseConditionSetsActionUnavailableIfConditionIsTrue(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenFalse(new Condition(true));
			assertEquals(false, action.available);
		}
		public function testAvailableFalseConditionsStack(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenFalse(new Condition(true));
			action.availableWhenFalse(new Condition(false));
			assertEquals(false, action.available);
		}
		public function testAvailableIsBindable(): void {
			var action:AbstractAction = new AbstractAction();
			var condition:Condition = new Condition(false);
			action.availableWhenTrue(condition);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(action, "available", recorder.invocationRecorder);
			condition.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
		public function testMessagesAreBindable(): void {
			var action:AbstractAction = new AbstractAction();
			var condition:Condition = new Condition(false);
			action.availableWhenTrue(condition);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(action, "messages", recorder.invocationRecorder);
			condition.trueMessage = "foo";
			condition.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
		public function testMessagesAsTooltipIsBindable(): void {
			var action:AbstractAction = new AbstractAction();
			var condition:Condition = new Condition(false);
			action.availableWhenTrue(condition);
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(action, "messagesAsTooltip", recorder.invocationRecorder);
			condition.trueMessage = "foo";
			condition.currentValue = true;
			assertEquals(1, recorder.invocationCount);
		}
		public function testMessagesContainsListOfCurrentMessagesFromConditionsThatAreFalse(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(false, "foo"));
			action.availableWhenTrue(new Condition(false, "bar"));
			action.availableWhenTrue(new Condition(true, "baz"));
			action.availableWhenTrue(new Condition(false));
			assertEquals(2, action.messages.length);
			assertEquals(true, action.messages.contains("foo"));
			assertEquals(true, action.messages.contains("bar"));
		}
		public function testMessagesAreEmptyWhenAvailable(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(true, "foo"));
			assertEquals(0, action.messages.length);
		}
		public function testMessagesAsTooltipIsNewLineSeperatedVersionOfMessages(): void {
			var action:AbstractAction = new AbstractAction();
			action.availableWhenTrue(new Condition(false, "foo"));
			action.availableWhenTrue(new Condition(false, "bar"));
			assertEquals("foo\nbar", action.messagesAsTooltip);
		}
	}
}