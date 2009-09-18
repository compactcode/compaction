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
		 * @param limit The string length must be greater than or equal to this value.
		 */
		function minLength(limit:int): IStringValidationBuilder;
		/**
		 * Adds a validation error if the string length is greater than the given limit.
		 * 
		 * Null values are ignored.
		 * 
		 * @param limit The string length must be less than or equal to this value.
		 */
		function maxLength(limit:int): IStringValidationBuilder;
		/**
		 * Adds a validation error if the string is not a valid email address.
		 * 
		 * Null and Empty values are ignored.
		 */
		function validEmail(): IStringValidationBuilder;
	}
}