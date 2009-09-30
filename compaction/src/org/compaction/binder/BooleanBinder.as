package org.compaction.binder {
	import mx.controls.CheckBox;
	
	/**
	 * Creates a two way binding between an object property and a CheckBox.
	 * 
	 * @author shanonmcquay
	 */
	public class BooleanBinder extends AbstractInputBinder {
		public function set target(target:CheckBox): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "selected";
		}
	}
}