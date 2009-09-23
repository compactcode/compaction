package org.compaction.condition {
	/**
	 * Provides a wrapper that ands the values of two given conditions together.
	 * 
	 * This condition is strictly read only.
	 * 
	 * @author shanonmcquay
	 */
	public class AndCondition extends ReadOnlyCondition {
		private var _delegateOne:ICondition;
		private var _delegateTwo:ICondition;
		public function AndCondition(delegateOne:ICondition, delegateTwo:ICondition) {
			_delegateOne = delegateOne;
			_delegateTwo = delegateTwo;
			createBindingDependancy(_delegateOne);
			createBindingDependancy(_delegateTwo);
		}
		[Bindable(event="readOnlyCurrentValueChanged")]
		override public function get currentValue():Boolean {
			return _delegateOne.currentValue && _delegateTwo.currentValue;
		}
		[Bindable(event="readOnlyCurrentMessageChanged")]
		override public function get currentMessage(): String {
			if(_delegateOne.currentMessage) {
				return _delegateOne.currentMessage;
			}
			if(_delegateTwo.currentMessage) {
				return _delegateTwo.currentMessage;
			} 
			return null;
		}
	}
}