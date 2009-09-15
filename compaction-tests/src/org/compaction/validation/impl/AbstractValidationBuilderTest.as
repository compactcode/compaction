package org.compaction.validation.impl {
	
	import org.compaction.validation.IValidationBuilder;
	import org.mockito.MockitoTestCase;
	
	public class AbstractValidationBuilderTest extends MockitoTestCase {
		
		private var _builder:AbstractValidationBuilder;
		private var _parent:IValidationBuilder;
		
		public function AbstractValidationBuilderTest() {
			super([IValidationBuilder]);
		}
		
		override public function setUp():void {
			_parent = mock(IValidationBuilder);
		}
		
		public function testErrorsAreAddedWithKey(): void {
			_builder = new AbstractValidationBuilder(null, _parent, "key");
			_builder.addError("foo");
			verify().that(_parent.addError("foo", "key"));
		}
	}
}