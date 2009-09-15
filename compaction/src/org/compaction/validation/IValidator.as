package org.compaction.validation {
	/**
	 * The validator is responsible for validating the given object using the given builder.
	 * 
	 * @author shanonmcquay
	 */
	public interface IValidator {
		/**
		 * Validate the given item.
		 * @param item The item to validate.
		 * @param builder The builder that will collect the results of the validation.
		 */
		function validate(item:Object, builder:IValidationBuilder): void;
	}
}