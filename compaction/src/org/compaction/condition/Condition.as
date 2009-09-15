package org.compaction.condition {
	/**
	 * Default implementation of ICondition
	 * 
	 * @author shanonmcquay
	 */
	public class Condition implements ICondition {
		private var _currentValue:Boolean;
		private var _currentMessage:String;
		private var _falseMessage:String;
		private var _trueMessage:String;
		public function Condition(defaultValue:Boolean, currentMsg:String=null) {
			_currentValue = defaultValue;
			_currentMessage = currentMsg;
		}
		[Bindable]
		public function get currentValue():Boolean {
			return _currentValue;
		}
		public function set currentValue(value:Boolean): void {
			_currentValue = value;
			refreshCurrentMessage();
		}
		[Bindable]
		public function get currentMessage(): String {
			return _currentMessage;
		}
		private function set currentMessage(value:String): void {
			_currentMessage = value;
		}
		public function set falseMessage(value:String):void {
			_falseMessage = value;
			refreshCurrentMessage();
		}
		public function set trueMessage(value:String):void {
			_trueMessage = value;
			refreshCurrentMessage();
		}
		private function refreshCurrentMessage(): void {
			if(_currentValue == true) {
				currentMessage = _trueMessage;
			} else {
				currentMessage = _falseMessage;
			}
		}
	}
}