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
		
		// -- Before Today
		
		public function testBeforeTodayAddsErrorIfRoutineFails(): void {
			var testDate:Date = new Date();
			given(_routines.afterToday(testDate)).willReturn(true);
			given(_messages.wasAfterToday()).willReturn("foorequired");
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.onOrBeforeToday();
			verify().that(_parent.addError("foorequired", "key"));
		}
		public function testBeforeTodayDoesNothingIfRoutinePasses(): void {
			var testDate:Date = new Date();
			given(_routines.afterToday(testDate)).willReturn(false);
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.onOrBeforeToday();
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeTodayIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.onOrBeforeToday());
		}
		
		// -- Before
		
		public function testBeforeAddsErrorIfRoutineFails(): void {
			var tomorrow:Date = new Date();
			var today:Date = new Date();
			
			given(_routines.after(today, tomorrow)).willReturn(true);
			given(_messages.wasAfter(today)).willReturn("after");
			
			_builder = new DateValidationBuilder(tomorrow, _parent, "key");
			_builder.onOrBefore(today);
			
			verify().that(_parent.addError("after", "key"));
		}
		public function testBeforeDoesNothingIfRoutinePasses(): void {
			var tomorrow:Date = new Date();
			var today:Date = new Date();
			
			given(_routines.after(tomorrow, today)).willReturn(false);
			
			_builder = new DateValidationBuilder(today, _parent, "key");
			_builder.onOrBefore(tomorrow);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.onOrBefore(null));
		}
		
		// -- Ater
		
		public function testAfterAddsErrorIfRoutineFails(): void {
			var today:Date = new Date();
			var tommorrow:Date = new Date();
			
			given(_routines.before(tommorrow, today)).willReturn(true);
			given(_messages.wasBefore(tommorrow)).willReturn("before");
			
			_builder = new DateValidationBuilder(today, _parent, "key");
			_builder.onOrAfter(tommorrow);
			
			verify().that(_parent.addError("before", "key"));
		}
		public function testAfterDoesNothingIfRoutinePasses(): void {
			var today:Date = new Date();
			var tommorrow:Date = new Date();
			
			given(_routines.before(today, tommorrow)).willReturn(false);
			
			_builder = new DateValidationBuilder(tommorrow, _parent, "key");
			_builder.onOrAfter(today);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testAfterIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.onOrAfter(null));
		}
		
	}
}