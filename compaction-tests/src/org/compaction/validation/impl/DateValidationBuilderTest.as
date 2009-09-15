package org.compaction.validation.impl {
	
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	import org.mockito.MockitoTestCase;
	
	public class DateValidationBuilderTest extends MockitoTestCase {
		
		private var _builder:DateValidationBuilder;
		private var _parent:IValidationBuilder;
		private var _routines:ValidationRoutines;
		private var _messages:ValidationMessages;
		
		public function DateValidationBuilderTest() {
			super([IValidationBuilder, ValidationRoutines, ValidationMessages]);
		}
		
		override public function setUp():void {
			_parent = mock(IValidationBuilder);
			_routines = mock(ValidationRoutines);
			_messages = mock(ValidationMessages);
			
			given(_parent.routines).willReturn(_routines);
			given(_parent.messages).willReturn(_messages);
		}
		
		public function testBeforeTodayAddsErrorIfRoutineFails(): void {
			var testDate:Date = new Date();
			given(_routines.afterToday(testDate)).willReturn(true);
			given(_messages.wasAfterToday()).willReturn("foorequired");
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.beforeToday();
			verify().that(_parent.addError("foorequired", "key"));
		}
		public function testBeforeTodayDoesNothingIfRoutinePasses(): void {
			var testDate:Date = new Date();
			given(_routines.afterToday(testDate)).willReturn(false);
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.beforeToday();
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeTodayIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.beforeToday())
		}
		
	}
}