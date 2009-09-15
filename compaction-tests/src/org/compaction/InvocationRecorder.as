package org.compaction {
	public class InvocationRecorder {
		public var invocationCount:int = 0;
		public function invocationRecorder(ignored:Object=null): void {
			invocationCount++;
		}
	}
}