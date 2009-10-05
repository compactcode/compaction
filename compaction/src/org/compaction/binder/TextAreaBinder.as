package org.compaction.binder {
	import mx.controls.TextArea;
	
	public class TextAreaBinder extends AbstractInputBinder {
		public function set target(target:TextArea): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "text";
		}
	}
}