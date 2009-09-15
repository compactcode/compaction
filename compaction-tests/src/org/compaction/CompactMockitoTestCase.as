package org.compaction {
	import org.mockito.MockitoTestCase;
	
	public class CompactMockitoTestCase extends MockitoTestCase {
		public function CompactMockitoTestCase(mock:Array) {
			super(mock);
		} 
			
		public function argThatMatches(matcher:Function): * {
			return argThat(new FunctionMatcher(matcher));
		}
	}
}