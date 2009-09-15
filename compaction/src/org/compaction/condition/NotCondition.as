package org.compaction.condition {
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	
	/**
	 * Provides a wrapper that negates the value of the given condition.
	 * 
	 * This condition is strictly read only.
	 * 
	 * @author shanonmcquay
	 */
	 [Bindable]
	public class NotCondition implements ICondition {
		private var _delegate:ICondition;
		public function NotCondition(delegate:ICondition) {
			_delegate = delegate;
			ChangeWatcher.watch(_delegate, "currentValue", dispatchCurrentValueChangeEvent);
			ChangeWatcher.watch(_delegate, "currentMessage", dispatchCurrentMessageChangeEvent);
		}
		[Bindable(event="notCurrentValueChanged")]
		public function get currentValue():Boolean {
			return !_delegate.currentValue;
		}
		[Bindable(event="notCurrentMessageChanged")]
		public function get currentMessage(): String {
			return _delegate.currentMessage;
		}
		private function dispatchCurrentValueChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("notCurrentValueChanged"));
		}
		private function dispatchCurrentMessageChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("notCurrentMessageChanged"));
		}
		public function set falseMessage(value:String):void {
			throwReadOnlyError();
		}
		public function set trueMessage(value:String):void {
			throwReadOnlyError();
		}
		private function throwReadOnlyError(): void {
			throw new Error("Not conditions are read only.");
		}
	}
}