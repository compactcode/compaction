package org.compaction.validation {
	/**
	 * Provides a simple interface for validating dates.
	 * 
	 * @author shanonmcquay
	 */
	public interface IDateValidationBuilder {
		/**
		 * Adds a validation error if the date is on or after today. 
		 * 
		 * Null values are ignored.
		 */
		function beforeToday(): IDateValidationBuilder;
		/**
		 * Adds a validation error if the date is on or after the given max.
		 *  
		 * @param max The date must be before this date.
		 */
		function before(max:Date): IDateValidationBuilder;
		/**
		 * Adds a validation error if the date is on or before the given min.
		 * 
		 * @param min The date must be after this date.
 		 */
		function after(min:Date): IDateValidationBuilder;
	}
}