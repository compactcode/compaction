package org.compaction.validation {
	import mx.validators.IValidatorListener;
	
	/**
	 * The validator adapter is responsible for triggering validation and notifying listeners 
	 * about the results of validations performed by a single validator.
	 * 
	 * @author shanonmcquay
	 */
	public interface IValidatorAdapter {
		/**
		 * An adapter is paired to a single validator.
		 * 
		 * @param validator The validator that will perform the validation.
		 */
		function set validator(validator:IValidator): void;
		/**
		 * Triggers validation and notifys all validation listeners of the results.
		 * 
		 * @param item The item to validate.
		 * @return True if no validation errors were recorded.
		 */
		function validate(item:Object): Boolean;
		/**
		 * Notify the given listener of the results of subsequent validations.
		 * 
		 * @param listener The listener to notify.
		 * @param key (optional) Only receive nofication for  with the given key.
		 */
		function attachListener(listener:IValidatorListener, key:String=null): void;
		/**
		 * Stop a validation listener from being notified of subsequent validations.
		 * 
		 * @param listener The listener to remove.
		 */
		function removeListener(listener:IValidatorListener): void;
	}
}