package org.compaction.validation.impl {
	
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	import org.mockito.MockitoTestCase;
	
	public class StringValidationBuilderTest extends MockitoTestCase {
		private var _builder:StringValidationBuilder;
		private var _parent:IValidationBuilder;
		private var _routines:ValidationRoutines;
		private var _messages:ValidationMessages;
		public function StringValidationBuilderTest() {
			super([IValidationBuilder, ValidationRoutines, ValidationMessages]);
		}
		override public function setUp():void {
			_parent = mock(IValidationBuilder);
			_routines = mock(ValidationRoutines);
			_messages = mock(ValidationMessages);
			
			given(_parent.routines).willReturn(_routines);
			given(_parent.messages).willReturn(_messages);
		}
		
		// -- Not Empty
		
		public function testNotEmptyAddsErrorIfRoutineFails(): void {
			given(_routines.empty("foo")).willReturn(true);
			given(_messages.wasRequired()).willReturn("foorequired");
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.notEmpty();
			verify().that(_parent.addError("foorequired", "key"));
		}
		public function testNotEmptyDoesNothingIfRoutinePasses(): void {
			given(_routines.empty("foo")).willReturn(false);
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.notEmpty();
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testNotEmptyIsFluent(): void {
			_builder = new StringValidationBuilder(null, _parent, null);
			assertEquals(_builder, _builder.notEmpty())
		}
	}
}