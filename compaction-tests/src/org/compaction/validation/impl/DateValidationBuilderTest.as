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
			given(_routines.beforeToday(testDate)).willReturn(false);
			given(_messages.mustBeBeforeToday()).willReturn("foorequired");
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.beforeToday();
			verify().that(_parent.addError("foorequired", "key"));
		}
		public function testBeforeTodayDoesNothingIfRoutinePasses(): void {
			var testDate:Date = new Date();
			given(_routines.beforeToday(testDate)).willReturn(true);
			_builder = new DateValidationBuilder(testDate, _parent, "key");
			_builder.beforeToday();
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeTodayDoesNothingIfValueIsNull() : void {
			_builder = new DateValidationBuilder(null, _parent, "key");
			_builder.beforeToday();
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeTodayIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.beforeToday());
		}
		
		// -- Before
		
		public function testBeforeAddsErrorIfRoutineFails(): void {
			var tomorrow:Date = new Date();
			var today:Date = new Date();
			
			given(_routines.before(today, tomorrow)).willReturn(false);
			given(_messages.mustBeBefore(today)).willReturn("error");
			
			_builder = new DateValidationBuilder(tomorrow, _parent, "key");
			_builder.before(today);
			
			verify().that(_parent.addError("error", "key"));
		}
		public function testBeforeDoesNothingIfRoutinePasses(): void {
			var tomorrow:Date = new Date();
			var today:Date = new Date();
			
			given(_routines.before(tomorrow, today)).willReturn(true);
			
			_builder = new DateValidationBuilder(today, _parent, "key");
			_builder.before(tomorrow);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeDoesNothingIfValueIsNull() : void {
			_builder = new DateValidationBuilder(null, _parent, "key");
			_builder.before(new Date());
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBeforeIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.before(null));
		}
		
		// -- Ater
		
		public function testAfterAddsErrorIfRoutineFails(): void {
			var today:Date = new Date();
			var tommorrow:Date = new Date();
			
			given(_routines.after(tommorrow, today)).willReturn(false);
			given(_messages.mustBeAfter(tommorrow)).willReturn("error");
			
			_builder = new DateValidationBuilder(today, _parent, "key");
			_builder.after(tommorrow);
			
			verify().that(_parent.addError("error", "key"));
		}
		public function testAfterDoesNothingIfRoutinePasses(): void {
			var today:Date = new Date();
			var tommorrow:Date = new Date();
			
			given(_routines.after(today, tommorrow)).willReturn(true);
			
			_builder = new DateValidationBuilder(tommorrow, _parent, "key");
			_builder.after(today);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testAfterDoesNothingIfValueIsNull() : void {
			_builder = new DateValidationBuilder(null, _parent, "key");
			_builder.after(new Date());
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testAfterIsFluent(): void {
			_builder = new DateValidationBuilder(new Date(), _parent, "key");
			assertEquals(_builder, _builder.after(null));
		}
		
	}
}