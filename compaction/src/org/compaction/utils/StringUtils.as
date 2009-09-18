package org.compaction.utils {
	/**
	 * A bunch of utility methods for dealing with strings.
	 * 
	 * @author shanonmcquay
	 */
	public class StringUtils {
		
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
		public static function contains(token:String, value:String): Boolean {
			if(!value) {
				return false;
			}
			return value.indexOf(token) != -1;
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
		public static function containsOccurances(token:String, value:String, occurances:int): Boolean {
			if(!value || !token) {
				return false;
			}
			var count:int = 0;
			var index:int = 0;
			while(index != -1) { 
				index = value.indexOf(token, index);
				if(index != -1) {
					count++;
					index++;
				}
			}
			return count == occurances;
		}
		
		/**
		 * Determine if the given value is null.
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value is null.
		 */
		public static function isNull(value:Object): Boolean {
			return value == null;
		}
		
		/**
		 * Determine if the given value is null or "".
		 * 
		 * @param value The value to check.
		 * 
		 * @return True if the value is not null or empty.
		 */
		public static function isEmpty(value:String): Boolean {
			return isNull(value) || value == "";
		}
		
		/**
		 * Determine if the given string ends with the given token. 
		 * 
		 * @param source The string to check.
		 * @param token The token to look for at the end of the string.
		 * 
		 * @return True if the given strings ends with the token. 
		 */
		public static function endsWith(source:String, token:String): Boolean {
			if(sourceIsAsLongAsToken(source, token)) {
				return token == source.substring(source.length - token.length, source.length);
			}
			return false;
		}
		
		/**
		 * Gets a substring of the given string from beginning until the last occurance of the given token.
		 * 
		 * @param source The string to check.
		 * @param token The token to look for.
		 * 
		 * @return Everything before the last occurance of the token.
		 */
		public static function everythingBefore(source:String, token:String): String {
			if(sourceIsAsLongAsToken(source, token)) {
				if(source == token) {
					return null;
				}
				return source.substring(0, source.indexOf(token));
			}
			return null;
		}
		
		private static function sourceIsAsLongAsToken(source:String, token:String): Boolean {
			return source && token && source.length >= token.length;
		} 
	}
}