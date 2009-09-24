package org.compaction {
	import org.compaction.model.IItemOperation;
	
	public class StubItemOperation implements IItemOperation {
		public static const SUCCESS:int = 1;
		public static const FAIL:int = 2;
		public static const WAIT:int = 3;
		private var type:int;
		public function StubItemOperation(type:int) {
			this.type = type;
		}
		public function execute(item:Object, onSuccess:Function, onFail:Function): void {
			if(type == SUCCESS) {
				onSuccess();
			} else if(type == FAIL) {
				onFail();
			}
		}
	}
}