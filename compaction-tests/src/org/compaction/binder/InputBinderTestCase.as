package org.compaction.binder {
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	
	import mx.events.PropertyChangeEvent;
	import mx.utils.ObjectProxy;
	
	import org.compaction.BindableCustomer;
	
	public class InputBinderTestCase extends TestCase {
		protected var _binder:*;
		protected var _source:BindableCustomer;
		protected var _property:String;
		protected var _target:*;
		override public function setUp():void {
			_source = new BindableCustomer();
		}
		public function testSettingSourceAloneDoesNothing(): void {
			_binder.source = _source;
		}
		public function testSettingPropertyAloneDoesNothing():void {
			_binder.property = _property;
		}
		public function testSettingTargetAloneDoesNothing(): void {
			_binder.target = _target;
		}
		public function testSettingSourceAndPropertyAloneDoesNothing():void {
			_binder.source = _source;
			_binder.property = _property;
		}	
		public function testSettingSourceAndTargetAloneDoesNothing():void {
			_binder.source = _source;
			_binder.target = _target;
		}
		public function testSettingPropertyAndTargetAloneDoesNothing():void {
			_binder.property = _property;
			_binder.target = _target;
		}
		public function testRemovingSourceRemovesAllEventListeners(): void {
			var proxy:ObjectProxy = new ObjectProxy(_source);
			_binder.source = proxy;
			_binder.property = _property;
			_binder.target = _target;
			_binder.source = null;
			assertFalse(proxy.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		public function testRemovingTargetRemovesAllEventListeners(): void {
			_binder.source = _source;
			_binder.property = _property;
			_binder.commitEvent = Event.CHANGE;
			_binder.target = _target;
			_binder.target = null;
			assertFalse(_target.hasEventListener(Event.CHANGE));
		}
	}
}