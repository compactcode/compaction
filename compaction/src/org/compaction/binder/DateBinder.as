package org.compaction.binder {
	
	import mx.controls.DateField;
	
	/**
	 * Creates a two way binding between an object property and a DateField.
	 * 
	 * @author shanonmcquay
	 */
	public class DateBinder extends AbstractInputBinder {
		public function set target(target:DateField): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "selectedDate";
		}
	}
}