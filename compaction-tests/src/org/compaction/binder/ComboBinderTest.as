package org.compaction.binder {
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	
	import org.compaction.model.EditModel;
	
	public class ComboBinderTest extends InputBinderTestCase {
		private var names:ArrayCollection = new ArrayCollection();
		override public function setUp():void {
			super.setUp();
			_property = "name";
			
			_target = new ComboBox();
			_target.dataProvider = names;
			_target.initialize();
			
			names.addItem("Shanon");
			names.addItem("Mike");
			names.addItem("Claire");
			
			_binder = new ComboBinder();
		}
		public function testSourcePropertyBoundToTargetSelection(): void {
			_source.name = "Shanon";
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			assertEquals("Shanon", _target.selectedItem);
			_source.name = "Claire";
			assertEquals("Claire", _target.selectedItem);
		}
		public function testTargetChangeUpdatesSourceProperty(): void {
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			_target.selectedItem = "Shanon";
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals("Shanon", _source[_property]);
		}
		public function testSourcePropertyBoundToTargetSelectionWhenUsingDotNotation(): void {
			_source.name = "Shanon";
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.name";
			_binder.target = _target;
			assertEquals("Shanon", _target.selectedItem);
			_source.name = "Claire";
			assertEquals("Claire", _target.selectedItem);
		}	
		public function testTargetChangeUpdatesSourceUsingDotNotation(): void {
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited.name";
			_binder.target = _target;
			_target.selectedItem = "Shanon";
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertEquals("Shanon", _source[_property]);
		}

	}
}