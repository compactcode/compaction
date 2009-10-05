package org.compaction.binder {
	import flash.events.Event;
	
	import mx.controls.TextArea;
	
	import org.compaction.model.EditModel;
	
	public class TextAreaBinderTest extends InputBinderTestCase {
		override public function setUp():void {
			super.setUp();
			_property = "name";
			_target = new TextArea();
			_binder = new TextAreaBinder();
		}
		public function testSourcePropertyBoundToTargetText(): void {
			_source.name = "shanon";
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			assertEquals("shanon", _target.text);
			_source.name = "fred";
			assertEquals("fred", _target.text);
		}
		public function testTargetChangeUpdatesSourceProperty(): void {
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			_target.text = "shanon";
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals("shanon", _source[_property]);
		}
		public function testSourcePropertyBoundToTargetTextWhenUsingDotNotation(): void {
			_source.name = "shanon";
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.name";
			_binder.target = _target;
			assertEquals("shanon", _target.text);
			_source.name = "fred";
			assertEquals("fred", _target.text);
		}	
		public function testTargetChangeUpdatesSourceUsingDotNotation(): void {
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.name";
			_binder.target = _target;
			_target.text = "shanon";
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals("shanon", _source[_property]);
		}
	}
}