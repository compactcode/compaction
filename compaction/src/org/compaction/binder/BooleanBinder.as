package org.compaction.binder {
	import mx.controls.CheckBox;
	
	public class BooleanBinder extends AbstractInputBinder {
		public function set target(target:CheckBox): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "selected";
		}
		override protected function get targetPropertyValue(): Object {
			return CheckBox(_target).selected;
		}
	}
}