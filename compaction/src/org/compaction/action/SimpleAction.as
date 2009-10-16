package org.compaction.action {
	public class SimpleAction extends AbstractAction implements ISimpleAction {
		private var _execute:Function
		private var _beforeExecute:Array= [];
		public function SimpleAction(execute:Function) {
			_execute = execute;
		}
		public function execute(): void {
			assertAvailable();
			for each(var listener:Function in _beforeExecute) {
				listener();
			}
			_execute();
		}
		public function beforeExecute(listener:Function): void {
			_beforeExecute.push(listener);
		}
	}
}