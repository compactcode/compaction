package org.compaction.binder {
	import mx.controls.ComboBox;
	
	public class ComboBinder extends AbstractInputBinder {
		public function set target(target:ComboBox): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "selectedItem";
		}
	}
}