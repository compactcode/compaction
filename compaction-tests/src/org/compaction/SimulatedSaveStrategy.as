package org.compaction {
	import org.compaction.model.IItemOperation;
	
	[Bindable] 
	public class SimulatedSaveStrategy implements IItemOperation {
		public var simulating:Boolean = false;
		public var simulateSuccess:Function;
		public var simulateFail:Function;
		public function execute(item:Object, onSuccess:Function, onFail:Function): void {
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