package org.compaction {
	import org.mockito.api.Matcher;
	
	public class FunctionMatcher implements Matcher {
		private var _matcher:Function;
		public function FunctionMatcher(matcher:Function) {
			_matcher = matcher; 
		}
		public function matches(value:*): Boolean {
			return _matcher(value);
		}
		public function describe(): String {
			return "unknown";
		}
	}
	
}