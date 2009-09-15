package org.compaction.action {
	public class ItemAction extends AbstractAction implements IItemAction {
		private var _execute:Function;
		public function ItemAction(execute:Function) {
			_execute = execute;
		}
		public function execute(item:Object): void {
			assertAvailable();
			_execute(item);
		}
	}
}