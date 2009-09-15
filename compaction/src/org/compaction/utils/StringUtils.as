package org.compaction.utils {
	/**
	 * A bunch of utility methods for dealing with strings.
	 * 
	 * @author shanonmcquay
	 */
	public class StringUtils {
		/**
		 * Determine if the given string ends with the given token. 
		 * @param source The string to check.
		 * @param token The token to look for at the end of the string.
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
		 * @param source The string to check.
		 * @param token The token to look for.
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