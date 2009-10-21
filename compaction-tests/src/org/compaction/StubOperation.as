package org.compaction {
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class StubOperation extends AbstractOperation {
		public static const SUCCESS:int = 1;
		public static const FAIL:int = 2;
		public static const WAIT:int = 3;
		private var _type:int;
		private var _result:Object;
		public function StubOperation(type:int, result:Object=null) {
			_type = type;
			_result = result;
		}
		override public function send(... args):AsyncToken {
			if(_type == SUCCESS) {
				dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, true, _result));
			} else if(_type == FAIL) {
				dispatchEvent(new FaultEvent(FaultEvent.FAULT));
			}
			return null;
		}
	}
}