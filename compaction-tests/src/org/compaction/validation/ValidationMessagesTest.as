package org.compaction.validation {
	
	import flexunit.framework.TestCase;
	
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
		public function testLowerThanMinMessage(): void {
			assertEquals("The amount entered is too small.", _messages.wasLowerThanMin());
		}
		public function testGreaterThanMaxMessage(): void {
			assertEquals("The number entered is too large.", _messages.wasGreaterThanMax());
		}
		public function testWasAfterTodayMessage(): void {
			assertEquals("The date entered must be on or before today.", _messages.wasAfterToday());
		}
	}
}