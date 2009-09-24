package org.compaction.binder {
	
	import mx.controls.TextInput;
	
	/**
	 * Creates a two way binding between an object property and a TextInput.
	 * 
	 * @author shanonmcquay
	 */
	public class TextBinder extends AbstractInputBinder {
		public function set target(target:TextInput): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "text";
		}
	}
}