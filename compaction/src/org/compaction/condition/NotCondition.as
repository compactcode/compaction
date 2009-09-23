package org.compaction.condition {
	import flash.events.Event;
	
	import mx.binding.utils.ChangeWatcher;
	
	/**
	 * Provides a wrapper that negates the value of the given condition.
	 * 
	 * This condition is strictly read only.
	 * 
	 * @author shanonmcquay
	 */
	 [Bindable]
	public class NotCondition extends ReadOnlyCondition {
		private var _delegate:ICondition;
		public function NotCondition(delegate:ICondition) {
			_delegate = delegate;
			createBindingDependancy(_delegate);
		}
		[Bindable(event="readOnlyCurrentValueChanged")]
		override public function get currentValue():Boolean {
			return !_delegate.currentValue;
		}
		[Bindable(event="readOnlyCurrentMessageChanged")]
		override public function get currentMessage(): String {
			return _delegate.currentMessage;
		}
	}
}