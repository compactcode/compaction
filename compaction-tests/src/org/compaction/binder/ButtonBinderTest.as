package org.compaction.binder {
	import flash.events.MouseEvent;
	
	import flexunit.framework.TestCase;
	
	import mx.controls.Button;
	
	import org.compaction.InvocationRecorder;
	import org.compaction.action.SimpleAction;
	import org.compaction.condition.Condition;
	
	public class ButtonBinderTest extends TestCase {
		private var _binder:ButtonBinder;
		private var _source:SimpleAction;
		private var _recorder:InvocationRecorder;
		private var _target:Button;
		override public function setUp():void {
			_recorder = new InvocationRecorder();
			_source = new SimpleAction(_recorder.invocationRecorder);
			_target = new Button();
			_target.initialize();
			
			_binder = new ButtonBinder();
		}
		public function testSettingSourceDoesNothing(): void {
			_binder.source = _source;
		}
		public function testSettingTargetDoesNothing(): void {
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
		public function testSettingSourceAndTargetBindsSourceExecuteToTargetClick(): void {
			_source.availableWhenTrue(new Condition(true));
			_binder.source = _source;
			_binder.target = _target;
			_target.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			assertEquals(1, _recorder.invocationCount)
		}
		public function testRemovingSourceRemovesAllEventListeners(): void {
			_binder.source = _source;
			_binder.target = _target;
			_binder.source = null;
			assertFalse(_source.hasEventListener("actionAvailableChanged"));
			assertFalse(_source.hasEventListener("actionMessagesAsTooltipChanged"));
		}
	}
}