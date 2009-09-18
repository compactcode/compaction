package org.compaction.validation {
	
	import flexunit.framework.TestCase;
	
	public class ValidationRoutinesTest extends TestCase {
		
		private var _utils:ValidationRoutines;
		private var _oneDay:int = 1000 * 60 * 60 * 24;
		
		override public function setUp():void {
			_utils = new ValidationRoutines();
		}
		
		// -- Is Null
		
		public function testIsNullTrueWhenValueIsNull(): void {
			assertEquals(true, _utils.isNull(null));
		}
		public function testIsNullFalseWhenValueIsNotNull(): void {
			assertEquals(false, _utils.isNull(new Object()));
		}
		public function testIsNotNullFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.isNotNull(null));
		}
		public function testIsNotNullTrueWhenValueIsNotNull(): void {
			assertEquals(true, _utils.isNotNull(new Object()));
		}
		
		// -- Empty
		
		public function testEmptyTrueWhenValueIsNull(): void {
			assertEquals(true, _utils.empty(null));
		}
		public function testEmptyTrueWhenValueIsEmpty(): void {
			assertEquals(true, _utils.empty(""));
		}
		public function testEmptyFalseWhenValueIsPresent(): void {
			assertEquals(false, _utils.empty("invalid"));
		}
		
		// -- Not Empty
		
		public function testNotEmptyFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.notEmpty(null));
		}
		public function testNotEmptyFalseWhenValueIsBlank(): void {
			assertEquals(false, _utils.notEmpty(""));
		}
		public function testNotEmptyTrueWhenValueIsPresent(): void {
			assertEquals(true, _utils.notEmpty("valid"));
		}
		
		// -- Contains
		
		public function testContainsFalseIfTokenIsNull(): void {
			assertEquals(false, _utils.contains(null, "foo"));
		}
		
		// -- Contains Occurances
		
		public function testContainsOccurancesFalseIfValueIsNull(): void {
			assertEquals(false, _utils.containsOccurances(null, "foo", 2));
		}
		
		public function testContainsOccurancesFalseIfValueHasOneLessThanRequired(): void {
			assertEquals(false, _utils.containsOccurances("a", "happy", 2));
		}
		
		public function testContainsOccurancesFalseIfValueHasOneMoreThanRequired(): void {
			assertEquals(false, _utils.containsOccurances("p", "happy chappy", 2));
		}
		
		public function testContainsOccurancesTrueIfValueHasRequired(): void {
			assertEquals(true, _utils.containsOccurances("p", "happy", 2));
		}

		// -- Contains Characters Left Of
		
		public function testContainsAnythingLeftOfFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.containsAnythingLeftOf("a", null));
		}
		public function testContainsAnythingLeftOfFalseWhenTokenIsNull(): void {
			assertEquals(false, _utils.containsAnythingLeftOf(null, "a"));
		}
		public function testContainsAnythingLeftOfFalseWhenValueContainsNotAts(): void {
			assertEquals(false, _utils.containsAnythingLeftOf("@", "a"));
		}
		public function testContainsAnythingLeftOfFalseWhenValueContainsNoCharactersBeforeFirstAt(): void {
			assertEquals(false, _utils.containsAnythingLeftOf("@", "@a"));
		}
		public function testContainsAnythingLeftOfTrueWhenValueContainsOneCharacterBeforeFirstAt(): void {
			assertEquals(true, _utils.containsAnythingLeftOf("@", "a@a"));
		}
		
		// -- Contains Tokens In order
		
		public function testContainsTokensInOrderFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.containsTokensInOrder("a", "b", null));
		}
		public function testContainsTokensInOrderFalseWhenFirstTokenIsNull(): void {
			assertEquals(false, _utils.containsTokensInOrder(null, "b", "c"));
		}
		public function testContainsTokensInOrderFalseWhenSecondTokenIsNull(): void {
			assertEquals(false, _utils.containsTokensInOrder("a", null, "c"));
		}
		public function testContainsTokensInOrderFalseWhenOnlyFirstTokenPresent(): void {
			assertEquals(false, _utils.containsTokensInOrder("a", "b", "a"));
		}
		public function testContainsTokensInOrderFalseWhenOnlySecondTokenPresent(): void {
			assertEquals(false, _utils.containsTokensInOrder("a", "b", "b"));
		}
		public function testContainsTokensInOrderFalseWhenBothTokensArePresentOutOfOrder(): void {
			assertEquals(false, _utils.containsTokensInOrder("a", "b", "ba"));
		}
		public function testContainsTokensInOrderFalseWhenBothTokensArePresentInOrder(): void {
			assertEquals(true, _utils.containsTokensInOrder("a", "b", "ab"));
		}
				
		// -- Less Than
		
		public function testLessThanFalseWhenValueIs19(): void {
			assertEquals(false, _utils.lessThan(18, 19));
		}
		public function testLessThan18TrueWhenValueIs17(): void {
			assertEquals(true, _utils.lessThan(18, 17));
		}
		
		// -- Greater Than
		
		public function testGreaterThan18TrueWhenValueIs19(): void {
			assertEquals(true, _utils.greaterThan(18, 19));
		}
		public function testGreaterThan18FalseWhenValueIs17(): void {
			assertEquals(false, _utils.greaterThan(18, 17));
		}

		// -- Greater Than Equal To

		public function testGreaterThanEqualTo18TrueWhenValueIs18(): void {
			assertEquals(true, _utils.greaterThanEqualTo(18, 18));
		}		
		public function testGreaterThanEqualTo18TrueWhenValueIs19(): void {
			assertEquals(true, _utils.greaterThanEqualTo(18, 19));
		}
		public function testGreaterThanEqualTo18FalseWhenValueIs17(): void {
			assertEquals(false, _utils.greaterThanEqualTo(18, 17));
		}
		
		// -- Less Than Equal To
		
		public function testLessThanEqualTo18TrueWhenValueIs18(): void {
			assertEquals(true, _utils.lessThanEqualTo(18, 18));
		}		
		public function testLessThanEqualTo18FalseWhenValueIs19(): void {
			assertEquals(false, _utils.lessThanEqualTo(18, 19));
		}
		public function testLessThanEqualTo18TrueWhenValueIs17(): void {
			assertEquals(true, _utils.lessThanEqualTo(18, 17));
		}
		
		// -- After Today
		
		public function testAfterTodayFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.afterToday(null));
		}
		public function testAfterTodayFalseWhenValueIsYesterday(): void {
			var date:Date = new Date();
			date.setTime(date.getTime() - _oneDay);
			assertEquals(false, _utils.afterToday(date));
		}
		public function testAfterTodayFalseWhenValueIsToday(): void {
			assertEquals(false, _utils.afterToday(new Date()));
		}
		public function testAfterTodayTrueWhenValueIsTomorrow(): void {
			var date:Date = new Date();
			date.setTime(date.getTime() + _oneDay);
			assertEquals(true, _utils.afterToday(date));
		}
		
		// -- After
				
		public function testAfterFalseWhenMinIsNull(): void {
			assertEquals(false, _utils.after(null, new Date()));
		}
				
		// -- Before
		
		public function testBeforeFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.before(new Date(), null));
		}
		public function testBeforeFalseWhenMaxIsNull(): void {
			assertEquals(false, _utils.before(null, new Date()));
		}
		public function testBeforeFalseWhenValueIsYesterday(): void {
			var today:Date = new Date();
			var yesterday:Date = new Date();
			yesterday.setTime(yesterday.getTime() - _oneDay);
			assertEquals(false, _utils.before(yesterday, today));
		}
		public function testBeforeFalseWhenValueIsToday(): void {
			assertEquals(false, _utils.before(new Date(), new Date()));
		}
		public function testBeforeTrueWhenValueIsTomorrow(): void {
			var today:Date = new Date();
			var tomorrow:Date = new Date();
			tomorrow.setTime(today.getTime() + _oneDay);
			assertEquals(true, _utils.before(tomorrow, today));
		}

		// -- Same Date

		public function testSameDateFalseWhenFirstDateIsNull(): void {
			assertEquals(false, _utils.sameDate(null, new Date()));
		}
		public function testSameDateFalseWhenSecondDateIsNull(): void {
			assertEquals(false, _utils.sameDate(new Date(), null));
		}		
		public function testSameDateTrueWhenBothDatesAreToday(): void {
			assertEquals(true, _utils.sameDate(new Date(), new Date()));
		}
	}
}