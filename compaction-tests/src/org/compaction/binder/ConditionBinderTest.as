package org.compaction.binder {
	import flexunit.framework.TestCase;
	
	import mx.containers.Form;
	import mx.events.PropertyChangeEvent;
	import mx.utils.ObjectProxy;
	
	import org.compaction.condition.Condition;
	
	public class ConditionBinderTest extends TestCase {
		private var _binder:ConditionBinder;
		private var _source:Condition;
		private var _target:Form;
		override public function setUp():void {
			_source = new Condition(false, "foo");
			_target = new Form();
			_target.initialize();
			_binder = new ConditionBinder();
		}
		public function testSettingSourceAloneDoesNothing(): void {
			_binder.source = _source;
		}
		public function testSettingTargetAloneDoesNothing(): void {
			_binder.target = _target;
		}
		public function testSettingSourceThenTargetBindsSourceCurrentValueToTargetEnabled() : void {
			_binder.source = _source;
			_binder.target = _target;
			assertEquals(false, _target.enabled);
			_source.currentValue = true;
			assertEquals(true, _target.enabled);
		}
		public function testSettingTargetThenSourceBindsSourceCurrentValueToTargetEnabled() : void {
			_binder.target = _target;
			_binder.source = _source;
			assertEquals(false, _target.enabled);
			_source.currentValue = true;
			assertEquals(true, _target.enabled);
		}
		public function testSettingSourceThenTargetBindsSourceCurrentMessageToTargetTooltip() : void {
			_binder.source = _source;
			_binder.target = _target;
			assertEquals("foo", _target.toolTip);
			_source.currentMessage = "bar";
			assertEquals("bar", _target.toolTip);
		}
		public function testRemovingSourceRemovesAllEventListeners(): void {
			_binder.source = _source;
			_binder.target = _target;
			_binder.source = null;
			assertFalse(_source.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE));
		}
	}
}