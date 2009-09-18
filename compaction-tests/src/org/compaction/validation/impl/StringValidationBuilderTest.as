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
		
		// -- Min Length
		
		public function testMinLengthAddsErrorIfRoutineFails(): void {
			given(_routines.lessThan(4, 3)).willReturn(true);
			given(_messages.wasLowerThanCharacterMin(4)).willReturn("lowerthanmin");
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.minLength(4);
			verify().that(_parent.addError("lowerthanmin", "key"));
		}
		public function testMinLengthDoesNothingIfRoutinePasses(): void {
			given(_routines.lessThan(2, 3)).willReturn(false);
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.minLength(2);
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testMinLengthDoesNotValidateIfValueIsNull() : void {
			_builder = new StringValidationBuilder(null, _parent, "key");
			_builder.minLength(2);
			verify(never()).that(_routines.lessThan(any(), any()));
			verify(never()).that(_messages.wasLowerThanCharacterMin(any()));
		}
		public function testMinLengthIsFluent(): void {
			_builder = new StringValidationBuilder(null, _parent, null);
			assertEquals(_builder, _builder.minLength(2));
		}
		
		// -- Max Length
		
		public function testMaxLengthAddsErrorIfRoutineFails(): void {
			given(_routines.greaterThan(2, 3)).willReturn(true);
			given(_messages.wasGreaterThanCharacterMax(2)).willReturn("greaterthanmax");
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.maxLength(2);
			verify().that(_parent.addError("greaterthanmax", "key"));
		}
		public function testMaxLengthDoesNothingIfRoutinePasses(): void {
			given(_routines.greaterThan(4, 3)).willReturn(false);
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.maxLength(4);
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testMaxLengthDoesNotValidateIfValueIsNull() : void {
			_builder = new StringValidationBuilder(null, _parent, "key");
			_builder.maxLength(2);
			verify(never()).that(_routines.greaterThan(any(), any()));
			verify(never()).that(_messages.wasGreaterThanCharacterMax(any()));
		}
		public function testMaxLengthIsFluent(): void {
			_builder = new StringValidationBuilder(null, _parent, null);
			assertEquals(_builder, _builder.maxLength(2));
		}
		
		// -- Valid Email
		
		public function testValidEmailAddsErrorIfNoAtSign(): void {
			given(_routines.notEmpty(any())).willReturn(true);
			
			given(_routines.contains("@", "foo")).willReturn(false);
			given(_messages.wasMissingAtSign()).willReturn("noatsign");
			
			_builder = new StringValidationBuilder("foo", _parent, "key");
			_builder.validEmail();
			
			verify().that(_parent.addError("noatsign", "key"));
		}
		public function testValidEmailAddsErrorIfTooManyAtSigns(): void {
			given(_routines.notEmpty(any())).willReturn(true);
			
			given(_routines.contains("@", "@foo@")).willReturn(true);
			given(_routines.containsOccurances("@", "@foo@", 1)).willReturn(false);
			given(_messages.wasTooManyAtSigns()).willReturn("toomanyatsign");
			
			_builder = new StringValidationBuilder("@foo@", _parent, "key");
			_builder.validEmail();
			
			verify().that(_parent.addError("toomanyatsign", "key"));
		}
		public function testValidEmailAddsErrorIfNothingLeftOfAtSign(): void {
			given(_routines.notEmpty(any())).willReturn(true);
			
			given(_routines.contains("@", "@a")).willReturn(true);
			given(_routines.containsOccurances("@", "@a", 1)).willReturn(true);
			given(_routines.containsAnythingLeftOf("@", "@a")).willReturn(false);
			
			given(_messages.wasMissingUserName()).willReturn("missinguser");
			
			_builder = new StringValidationBuilder("@a", _parent, "key");
			_builder.validEmail();
			
			verify().that(_parent.addError("missinguser", "key"));
		}
		public function testValidEmailAddsErrorIfNoDotRightOfAtSign(): void {
			given(_routines.notEmpty(any())).willReturn(true);
			
			given(_routines.contains("@", "@a")).willReturn(true);
			given(_routines.containsOccurances("@", "@a", 1)).willReturn(true);
			given(_routines.containsAnythingLeftOf("@", "@a")).willReturn(true);
			given(_routines.containsTokensInOrder("@", ".", "@a")).willReturn(false);
			
			given(_messages.wasMissingPeriodInDomain()).willReturn("missingperiod");
			
			_builder = new StringValidationBuilder("@a", _parent, "key");
			_builder.validEmail();
			
			verify().that(_parent.addError("missingperiod", "key"));
		}
		public function testValidEmailDoesNothingIfNoRoutinesFail(): void {
			given(_routines.notEmpty(any())).willReturn(true);
			
			given(_routines.contains("@", "a@a.com")).willReturn(true);
			given(_routines.containsOccurances("@", "a@a.com", 1)).willReturn(true);
			given(_routines.containsAnythingLeftOf("@", "a@a.com")).willReturn(true);
			given(_routines.containsTokensInOrder("@", ".", "a@a.com")).willReturn(true);
			
			_builder = new StringValidationBuilder("a@a.com", _parent, "key");
			_builder.validEmail();
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testValidEmailDoesNotValidateIfValueIsEmpty() : void {
			given(_routines.notEmpty(any())).willReturn(false);
			
			_builder = new StringValidationBuilder("", _parent, "key");
			_builder.validEmail();
			
			verify(never()).that(_routines.contains(any(), any()));
			verify(never()).that(_messages.wasMissingAtSign());
			
			verify(never()).that(_routines.containsOccurances(any(), any(), any()));
			verify(never()).that(_messages.wasTooManyAtSigns());
		}
		public function testValidEmailIsFluent(): void {
			_builder = new StringValidationBuilder(null, _parent, null);
			assertEquals(_builder, _builder.validEmail());
		}
		
	}
}