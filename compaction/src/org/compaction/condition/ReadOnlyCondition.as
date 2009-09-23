package org.compaction.condition {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.ChangeWatcher;
	
	/**
	 * Some common code read only conditions.
	 * 
	 * @author shanonmcquay
	 */
	public class ReadOnlyCondition extends EventDispatcher implements ICondition {
		public function get currentValue():Boolean {
			throw new Error("You must override this.");
		}
		public function get currentMessage(): String {
			throw new Error("You must override this.");
		}
		public function set falseMessage(value:String):void {
			throwReadOnlyError();
		}
		public function set trueMessage(value:String):void {
			throwReadOnlyError();
		}
		protected function createBindingDependancy(other:ICondition): void {
			ChangeWatcher.watch(other, "currentValue", dispatchCurrentValueChangeEvent);
			ChangeWatcher.watch(other, "currentMessage", dispatchCurrentMessageChangeEvent);
		}
		private function dispatchCurrentValueChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("readOnlyCurrentValueChanged"));
		}
		private function dispatchCurrentMessageChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("readOnlyCurrentMessageChanged"));
		}
		private function throwReadOnlyError(): void {
			throw new Error("This condition is read only.");
		}
	}
}