package org.compaction {
	import org.compaction.model.ISaveStrategy;
	
	[Bindable] 
	public class SimulatedSaveStrategy implements ISaveStrategy {
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