package org.compaction.binder {
	import flexunit.framework.TestCase;
	
	import mx.controls.List;
	import mx.events.ListEvent;
	
	import org.compaction.InvocationRecorder;
	import org.compaction.action.ItemAction;
	import org.compaction.condition.Condition;
	
	public class ListBinderTest extends TestCase {
		private var _binder:ListBinder;
		private var _source:ItemAction;
		private var _recorder:InvocationRecorder;
		private var _target:List;
		override public function setUp():void {
			_recorder = new InvocationRecorder();
			
			_source = new ItemAction(_recorder.invocationRecorder);
			_target = new List();
			_target.initialize();
			
			_binder = new ListBinder();
		}
		public function testSettingSourceAloneDoesNothing(): void {
			_binder.source = _source;
		}
		public function testSettingTargetAloneDoesNothing(): void {
			_binder.target = _target;
		}
		public function testSettingSourceThenTargetBindsSourceAvailableToTargetEnabled(): void {
			var condition:Condition = new Condition(false);
			_source.availableWhenTrue(condition);
			_binder.source = _source;
			_binder.target = _target;
			assertEquals(false, _target.enabled);
			condition.currentValue = true;
			assertEquals(true, _target.enabled);
		}
		public function testSettingTargetThenSourceBindsSourceAvailableToTargetEnabled(): void {
			var condition:Condition = new Condition(false);
			_source.availableWhenTrue(condition);
			_binder.target = _target;
			_binder.source = _source;
			assertEquals(false, _target.enabled);
			condition.currentValue = true;
			assertEquals(true, _target.enabled);
		}
		public function testSettingSourceAndTargetBindsSourceTooltipToTargetTooltip(): void {
			var condition:Condition = new Condition(false, "foo");
			_source.availableWhenTrue(condition);
			_binder.source = _source;
			_binder.target = _target;
			assertEquals("foo", _target.toolTip);
			condition.currentValue = true;
			assertEquals("", _target.toolTip);
		}
		public function testSettingSourceAndTargetBindsSourceExecuteToTargetListChange(): void {
			_source.availableWhenTrue(new Condition(true));
			_binder.source = _source;
			_binder.target = _target;
			_target.dispatchEvent(new ListEvent(ListEvent.CHANGE));
			assertEquals(1, _recorder.invocationCount)
		}
		public function testRemovingSourceRemovesAllEventListeners(): void {
			_binder.source = _source;
			_binder.target = _target;
			_binder.source = null;
			assertFalse(_source.hasEventListener("actionAvailableChanged"));
			assertFalse(_source.hasEventListener("actionMessagesAsTooltipChanged"));
		}
		public function testRemovingTargetRemovesAllEventListeners(): void {
			_binder.source = _source;
			_binder.target = _target;
			_binder.target = null;
			assertFalse(_target.hasEventListener(ListEvent.CHANGE));
		}
	}
}