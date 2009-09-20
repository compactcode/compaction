package org.compaction.binder {
	import flash.events.Event;
	
	import mx.controls.CheckBox;
	
	import org.compaction.model.EditModel;
	
	public class BooleanBinderTest extends InputBinderTestCase {
		override public function setUp():void {
			super.setUp();
			_property = "active";
			
			_target = new CheckBox();
			_target.initialize();
			
			_binder = new BooleanBinder();
		}
		public function testSourcePropertyBoundToTargetSelected(): void {
			_source.active = false;
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			assertEquals(false, _target.selected);
			_source.active = true;
			assertEquals(true, _target.selected);
		}
		public function testTargetChangeUpdatesSourceProperty(): void {
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			_target.selected = true;
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals(true, _source[_property]);
		}
		public function testSourcePropertyBoundToTargetSelectedWhenUsingDotNotation(): void {
			_source.active = false;
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.active";
			_binder.target = _target;
			assertEquals(false, _target.selected);
			_source.active = true;
			assertEquals(true, _target.selected);
		}	
		public function testTargetChangeUpdatesSourceUsingDotNotation(): void {
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.active";
			_binder.target = _target;
			_target.selected = true;
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals(true, _source[_property]);
		}
	}
}