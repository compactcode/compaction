package org.compaction.action {
	public class SimpleAction extends AbstractAction implements ISimpleAction {
		private var _execute:Function
		public function SimpleAction(execute:Function) {
			_execute = execute;
		}
		public function execute(): void {
			assertAvailable();
			_execute();
		}
	}
}