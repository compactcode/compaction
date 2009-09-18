package org.compaction.validation {
	/**
	 * Provides a simple interface for validating numbers.
	 * 
	 * @author shanonmcquay
	 */
	public interface INumberValidationBuilder {
		/**
		 * Adds a validation error if the number is less than the min or greater than the max.
		 * 
		 * @param min The value must be greater than or equal to this value.
		 * @param max The value must be less than or equal to this value.
		 */
		function between(min:Number, max:Number): INumberValidationBuilder;
		/**
		 * Adds a validation error if the number is greater than or equal to the max.
		 * 
		 * @param max The value must be less than this value.
		 */
		function lessThan(max:int): INumberValidationBuilder;
		/**
		 * Adds a validation error if the number is less than or equal to the min.
		 * 
		 * @param min The value must be greater than this value.
		 */
		function greaterThan(min:int): INumberValidationBuilder;
	}
}