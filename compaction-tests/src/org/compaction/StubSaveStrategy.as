package org.compaction {
	import org.compaction.model.ISaveStrategy;
	
	public class StubSaveStrategy implements ISaveStrategy {
		public static const SUCCESS:int = 1;
		public static const FAIL:int = 2;
		public static const WAIT:int = 3;
		private var type:int;
		public function StubSaveStrategy(type:int) {
			this.type = type;
		}
		public function save(item:Object, onSuccess:Function, onFail:Function): void {
			if(type == SUCCESS) {
				onSuccess();
			} else if(type == FAIL) {
				onFail();
			}
		}
	}
}