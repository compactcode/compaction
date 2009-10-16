package org.compaction {
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class StubSaveOperation extends AbstractOperation {
		public static const SUCCESS:int = 1;
		public static const FAIL:int = 2;
		public static const WAIT:int = 3;
		private var type:int;
		public function StubSaveOperation(type:int) {
			this.type = type;
		}
		override public function send(... args:Array):AsyncToken {
			if(type == SUCCESS) {
				dispatchEvent(new ResultEvent(ResultEvent.RESULT));
			} else if(type == FAIL) {
				dispatchEvent(new FaultEvent(FaultEvent.FAULT));
			}
			return null;
		}
	}
}