package org.compaction.binder {
	import flexunit.framework.TestCase;
	
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
	}
}