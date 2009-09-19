package org.compaction.validation {
	import org.compaction.utils.StringUtils;
	
	/**
	 * Provides a range of simple routines for validating data.
	 * 
	 * @author shanonmcquay
	 */
	public class ValidationRoutines {
		
		/**
		 * Determine if the given value is null.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value is null.
		 */
		public function isNull(value:Object): Boolean {
			return value == null;
		}
		
		/**
		 * Determine if the given value is not null.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value is not null.
		 */
		public function isNotNull(value:Object): Boolean {
			return !isNull(value);
		}
		
		/**
		 * Determine if the given value is null or "".
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value is not null or empty.
		 */
		public function empty(value:String): Boolean {
			return StringUtils.isEmpty(value);
		}
		
		/**
		 * Determine if the given value contains at least one character.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value contains one or more characters.
		 */
		public function notEmpty(value:String): Boolean {
			return !empty(value);
		}
		
		/**
		 * Determine if the given value contains the given token.
		 * 
		 * Returns false if the value is null.
		 * 
		 * @param token The token to look for.
		 * @param value The value to check.
		 * 
		 * @return True if the value contains the token.
		 */
		public function contains(token:String, value:String): Boolean {
			return StringUtils.contains(token, value);
		}
		
		/**
		 * Determine if the given value contains a number of occurances of the given token.
		 * 
		 * Returns false if the value is null.
		 * 
		 * @param token The token to look for.
		 * @param value The value to check.
		 * @param occurances The number of times the token must occur in the given value.
		 * 
		 * @return True if the token occurs exactly the given number of times.
		 */
		public function containsOccurances(token:String, value:String, occurances:int): Boolean {
			return StringUtils.containsOccurances(token, value, occurances);
		}
		
		/**
		 * Determine if the given value contains any characters left of the first occurance of 
		 * the given token.
		 * 
		 * Returns false if the given value is null.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if at least one character exists before the first occurance of the token.
		 */
		public function containsAnythingLeftOf(token:String, value:String): Boolean {
			if(!value) {
				return false;
			}
			return value.indexOf(token) > 0;
		}
		
		/**
		 * Determine if the given value contains both given tokens, in order. 
		 * 
		 * Returns false if the any value is null.
		 * 
		 * @param first The first token to look for.
		 * @param second The second token to look for.
		 * @param value The value to check.
		 * 
		 * @return True if the given value contains both tokens, in order.
		 */
		public function containsTokensInOrder(first:String, second:String, value:String): Boolean {
			if(!first || !second || !value) {
				return false;
			}
			var firstIndex:int = value.indexOf(first);
			var secondIndex:int = value.indexOf(second);
			return (firstIndex != -1) && secondIndex > firstIndex;
		}
		
		/**
		 * Determine if the given value is less than the given max. 
		 * 
		 * @param max The value must be below this max.
		 * @param value The value to check.
		 * 
		 * @return True if the value is below the max. 
		 */
		public function lessThan(max:int, value:int): Boolean {
			return value < max;
		}
		
		/**
		 * Determine if the given value is greater than the given min. 
		 * 
		 * @param min The value must be above this min.
		 * @param value The value to check.
		 * 
		 * @return True if the value is above the min. 
		 */
		public function greaterThan(min:int, value:int): Boolean {
			return value > min;
		}
		
		/**
		 * As per greaterThan(), except the value can be equal to the limit
		 */
		public function greaterThanEqualTo(limit:int, value:int): Boolean {
			if(value == limit) {
				return true;
			}
			return greaterThan(limit, value);
		} 
		
		/**
		 * As per lessThan(), except the value can be equal to the max
		 */
		public function lessThanEqualTo(max:int, value:int): Boolean {
			if(value == max) {
				return true;
			}
			return lessThan(max, value);
		}
		
		/**
		 * Determines if the given date is on or before today.
		 * 
		 * Returns false if the given date is null.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True of the date is on or before today.
		 */
		public function beforeToday(value:Date): Boolean {
			return before(new Date(), value);
		}
		
		/**
		 * Determines if the given date is after the min date.
		 * 
		 * Returns false if either date is null.
		 *
		 * @param min The given date must be after this date.
		 * @param value The value to check.
		 * 
		 * @return True of the date is after the min date.
		 */
		public function after(min:Date, value:Date): Boolean {
			if(!min || !value) {
				return false;
			}
			if(sameDate(min, value)) {
				return false;
			}
			return value.getTime() > min.getTime();
		}
		
		/**
		 * Determines if the given date is before the max date.
		 * 
		 * Returns false if either date is null.
		 *
		 * @param max The value must be before date.
		 * @param value The value to check.
		 * 
		 * @return True of the date is before the max date.
		 */
		public function before(max:Date, value:Date): Boolean {
			if(!max || !value) {
				return false;
			}
			if(sameDate(max, value)) {
				return false;
			}
			return value.getTime() < max.getTime();
		}
		
		/**
		 * Determines if the given dates represent the same calendar day.
		 * 
		 * Returns false if either date is null.
		 *
		 * @return True of both dates represent the same calendar day.
		 */
		public function sameDate(one:Date, two:Date): Boolean {
			if(!one || !two) {
				return false;
			}
			var sameDay:Boolean = true;
			sameDay = sameDay && one.fullYear == two.fullYear;
			sameDay = sameDay && one.month == two.month;
			sameDay = sameDay && one.date == two.date;
			return sameDay;
		}
		
	}
}