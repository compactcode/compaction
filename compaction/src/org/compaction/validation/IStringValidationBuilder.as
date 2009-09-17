package org.compaction.validation {
	/**
	 * Provides a simple interface for validating strings.
	 * 
	 * @author shanonmcquay
	 */
	public interface IStringValidationBuilder {
		/**
		 * Adds a validation error if the string is null or "".
		 */
		function notEmpty(): IStringValidationBuilder;
		/**
		 * Adds a validation error if the string length is lower than the given limit.
		 * 
		 * Null values are ignored.
		 * 
		 * @param limit The string length must be greater than this value.
		 */
		function minLength(limit:int): IStringValidationBuilder;
		/**
		 * Adds a validation error if the string length is greater than the given limit.
		 * 
		 * Null values are ignored.
		 * 
		 * @param limit The string length must be less than this value.
		 */
		function maxLength(limit:int): IStringValidationBuilder;
	}
}