package org.compaction {
	import org.compaction.model.ISaveOperation;
	
	[Bindable] 
	public class SimulatedSaveOperation implements ISaveOperation {
		public var simulating:Boolean = false;
		public var simulateSuccess:Function;
		public var simulateFail:Function;
		public function save(item:Object, onSuccess:Function, onFail:Function): void {
			simulating = true;
			simulateSuccess = function(): void {
				simulating = false;
				onSuccess();
			}
			simulateFail = function(): void {
				simulating = false;
				onFail();
			}
		}
	}
}