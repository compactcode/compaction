package org.compaction.binder {
	import flash.events.Event;
	
	import mx.controls.DateField;
	
	import org.compaction.model.EditModel;
	
	public class DateBinderTest extends InputBinderTestCase {
		override public function setUp():void {
			super.setUp();
			_property = "birth";
			_target = new DateField();
			_binder = new DateBinder();
		}
		public function testSourcePropertyBoundToTargetSelectedDate(): void {
			_source.birth = new Date(2000, 1, 1);
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			assertDateEquals(_target.selectedDate, 2000, 1, 1);
			_source.birth = new Date(2005, 5, 5);
			assertDateEquals(_target.selectedDate, 2005, 5, 5);
		}
		public function testTargetChangeUpdatesSourceProperty(): void {
			_binder.source = _source;
			_binder.property = _property;
			_binder.target = _target;
			_target.selectedDate = new Date(2002, 2 ,2);
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertDateEquals(_source[_property], 2002, 2, 2);
		}
		public function testSourcePropertyBoundToTargetSelectedDateWhenUsingDotNotation(): void {
			_source.birth = new Date(2000, 1, 1);
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited." + _property;
			_binder.target = _target;
			assertDateEquals(_target.selectedDate, 2000, 1, 1);
			_source.birth = new Date(2005, 5, 5);
			assertDateEquals(_target.selectedDate, 2005, 5, 5);
		}
		public function testTargetChangeUpdatesSourceUsingDotNotation(): void {
			var editModel:EditModel = new EditModel();
			editModel.edit.execute(_source);
			_binder.source = editModel;
			_binder.property = "edited." + _property;
			_binder.target = _target;
			_target.selectedDate = new Date(2002, 2 ,2);
			_target.dispatchEvent(new Event(Event.CHANGE));
			assertDateEquals(_source[_property], 2002, 2, 2);
		}
		private function assertDateEquals(date:Date, year:int, month:int, day:int): void {
			if(!date) {
				fail("date was null");
			}
			assertEquals(year, date.fullYear);
			assertEquals(month, date.month);
			assertEquals(day, date.date);
		}
	}
}