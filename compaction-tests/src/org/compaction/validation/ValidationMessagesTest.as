package org.compaction.validation {
	
	import flexunit.framework.TestCase;
	
	import mx.formatters.DateFormatter;
	import mx.utils.StringUtil;
	
	public class ValidationMessagesTest extends TestCase {
		private var _messages:ValidationMessages;
		override public function setUp():void {
			_messages = new ValidationMessages();
		}
		public function testMustNotBeNullMessage(): void {
			assertEquals("This field is required.", _messages.mustNotBeNull());
		}
		public function testMustBeNullMessage(): void {
			assertEquals("Value must be null.", _messages.mustBeNull());
		}
		public function testMustBePresentMessage(): void {
			assertEquals("This field is required.", _messages.mustNotBeEmpty());
		}
		public function testMustNotPrecedeCharacterMinMessage(): void {
			assertEquals("The minimum length allowed is 5.", _messages.mustNotPrecedeCharacterMin(5));
		}
		public function testMustNotExceedCharacterMaxMessage(): void {
			assertEquals("The maximum length allowed is 5.", _messages.mustNotExceedCharacterMax(5));
		}
		public function testMustNotPrecedeMinMessage(): void {
			assertEquals("The minimum value allowed is 5.", _messages.mustNotPrecedeMin(5));
		}
		public function testMustNotExceedMaxMessage(): void {
			assertEquals("The maximum value allowed is 5.", _messages.mustNotExceedMax(5));
		}
		public function testMustBeBeforeTodayMessage(): void {
			assertEquals("The date entered must be before today.", _messages.mustBeBeforeToday());
		}
		public function testMustBeAfterMessage(): void {
			var date:Date = new Date(2000, 1, 27);
			var format:DateFormatter = new DateFormatter();
			var messageTemplate:String = "The date entered must be after {0}.";
			var expectedMessage:String = StringUtil.substitute(messageTemplate, format.format(date));
			assertEquals(expectedMessage, _messages.mustBeAfter(date));
		}
		public function testMustBeBeforeMessage(): void {
			var date:Date = new Date(2000, 1, 27);
			var format:DateFormatter = new DateFormatter();
			var messageTemplate:String = "The date entered must be before {0}.";
			var expectedMessage:String = StringUtil.substitute(messageTemplate, format.format(date));
			assertEquals(expectedMessage, _messages.mustBeBefore(date));
		}
		public function testWasMissingAtSignMessage(): void {
			assertEquals("An at sign (@) is missing in your e-mail address.", _messages.wasMissingAtSign());
		}
		public function testWasTooManyAtSignsMessage(): void {
			assertEquals("Your e-mail address contains too many @ characters.", _messages.wasTooManyAtSigns());
		}
		public function testWasMissingUserNameMessage(): void {
			assertEquals("The username in your e-mail address is missing.", _messages.wasMissingUserName());
		}
		public function testWasMissingPeriodInDomain(): void {
			assertEquals("The domain in your e-mail address is missing a period.", _messages.wasMissingPeriodInDomain());
		}
		
	}
}