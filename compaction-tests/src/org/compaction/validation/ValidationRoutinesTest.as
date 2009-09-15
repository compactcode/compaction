package org.compaction.validation {
	
	import flexunit.framework.TestCase;
	
	public class ValidationRoutinesTest extends TestCase {
		
		private var _utils:ValidationRoutines;
		private var _oneDay:int = 1000 * 60 * 60 * 24;
		
		override public function setUp():void {
			_utils = new ValidationRoutines();
		}
		
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
		
		public function testEmptyTrueWhenValueIsNull(): void {
			assertEquals(true, _utils.empty(null));
		}
		public function testEmptyTrueWhenValueIsEmpty(): void {
			assertEquals(true, _utils.empty(""));
		}
		public function testEmptyFalseWhenValueIsPresent(): void {
			assertEquals(false, _utils.empty("invalid"));
		}
		
		public function testNotEmptyFalseWhenValueIsNull(): void {
			assertEquals(false, _utils.notEmpty(null));
		}
		public function testNotEmptyFalseWhenValueIsBlank(): void {
			assertEquals(false, _utils.notEmpty(""));
		}
		public function testNotEmptyTrueWhenValueIsPresent(): void {
			assertEquals(true, _utils.notEmpty("valid"));
		}
		
		public function testLessThanFalseWhenValueIs19(): void {
			assertEquals(false, _utils.lessThan(18, 19));
		}
		public function testLessThan18TrueWhenValueIs17(): void {
			assertEquals(true, _utils.lessThan(18, 17));
		}
		
		public function testGreaterThan18TrueWhenValueIs19(): void {
			assertEquals(true, _utils.greaterThan(18, 19));
		}
		public function testGreaterThan18FalseWhenValueIs17(): void {
			assertEquals(false, _utils.greaterThan(18, 17));
		}

		public function testGreaterThanEqualTo18TrueWhenValueIs18(): void {
			assertEquals(true, _utils.greaterThanEqualTo(18, 18));
		}		
		public function testGreaterThanEqualTo18TrueWhenValueIs19(): void {
			assertEquals(true, _utils.greaterThanEqualTo(18, 19));
		}
		public function testGreaterThanEqualTo18FalseWhenValueIs17(): void {
			assertEquals(false, _utils.greaterThanEqualTo(18, 17));
		}
		
		public function testLessThanEqualTo18TrueWhenValueIs18(): void {
			assertEquals(true, _utils.lessThanEqualTo(18, 18));
		}		
		public function testLessThanEqualTo18FalseWhenValueIs19(): void {
			assertEquals(false, _utils.lessThanEqualTo(18, 19));
		}
		public function testLessThanEqualTo18TrueWhenValueIs17(): void {
			assertEquals(true, _utils.lessThanEqualTo(18, 17));
		}
		
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
	}
}