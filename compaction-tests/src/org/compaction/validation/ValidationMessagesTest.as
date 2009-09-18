package org.compaction.validation {
	
	import flexunit.framework.TestCase;
	
	import mx.formatters.DateFormatter;
	import mx.utils.StringUtil;
	
	public class ValidationMessagesTest extends TestCase {
		private var _messages:ValidationMessages;
		override public function setUp():void {
			_messages = new ValidationMessages();
		}
		public function testNullMessage(): void {
			assertEquals("This field is required.", _messages.wasNull());
		}
		public function testNotNullMessage(): void {
			assertEquals("Value must be null.", _messages.wasNotNull());
		}
		public function testRequiredMessage(): void {
			assertEquals("This field is required.", _messages.wasRequired());
		}
		public function testLowerThanMinCharacterMessage(): void {
			assertEquals("The minimum length allowed is 5.", _messages.wasLowerThanCharacterMin(5));
		}
		public function testGreaterThanMaxCharacterMessage(): void {
			assertEquals("The maximum length allowed is 5.", _messages.wasGreaterThanCharacterMax(5));
		}
		public function testLowerThanMinMessage(): void {
			assertEquals("The minimum value allowed is 5.", _messages.wasLowerThanMin(5));
		}
		public function testGreaterThanMaxMessage(): void {
			assertEquals("The maximum value allowed is 5.", _messages.wasGreaterThanMax(5));
		}
		public function testWasAfterTodayMessage(): void {
			assertEquals("The date entered must be on or before today.", _messages.wasAfterToday());
		}
		public function testWasAfterMessage(): void {
			var date:Date = new Date(2000, 1, 27);
			var format:DateFormatter = new DateFormatter();
			var messageTemplate:String = "The date entered must be on or before {0}.";
			var expectedMessage:String = StringUtil.substitute(messageTemplate, format.format(date));
			assertEquals(expectedMessage, _messages.wasAfter(date));
		}
		public function testWasBeforeMessage(): void {
			var date:Date = new Date(2000, 1, 27);
			var format:DateFormatter = new DateFormatter();
			var messageTemplate:String = "The date entered must be on or after {0}.";
			var expectedMessage:String = StringUtil.substitute(messageTemplate, format.format(date));
			assertEquals(expectedMessage, _messages.wasBefore(date));
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