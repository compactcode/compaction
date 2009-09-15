package org.compaction.validation {
	import mx.collections.ListCollectionView;
	
	/**
	 * The validation builder provides a means to collect and filter validation errors by key. 
	 * 
	 * It is also designed to provide easy access to a large number of validation routines and 
	 * error messages.
	 * 
	 * @author shanonmcquay
	 */
	public interface IValidationBuilder {
		
		/**
		 * Provides access to a range of standard validation routines.
		 * 
		 * For simple validation you shouldn't need to access these directly.
		 * 
		 * @return The built in validation routines.
		 */
		function get routines(): ValidationRoutines;
		
		/**
		 * Provides access to a range of standard internationalized validation messages.
		 * 
		 * For simple validation you shouldn't need to access these directly.
		 * 
		 * @return The build in validation error messages.
		 */
		function get messages(): ValidationMessages;
		
		/**
		 * Add a validation error.
		 * @param message The error message.
		 * @param key An optional key to associate with the error.
		 */
		function addError(message:String, key:String=null): void;
		
		/**
		 * Check if any error messages have been added.
		 * @return True if errors have been added.
		 */
		function hasErrors(): Boolean;
		
		/**
		 * Check if no error messages have been added.
		 * @return True if no errors have been added.
		 */
		function hasNoErrors(): Boolean;
		
		/**
		 * Return a list of all error messages that have been added.
		 * @return A list of simple strings.
		 */
		function errors():ListCollectionView;
		
		/**
		 * Return a list of all error messages that have been added, transformed into ValidationResults.
		 * @return A list of ValidationResults.
		 */
		function results():ListCollectionView;
		
		/**
		 * Return a list of all error messages that have been added, transformed into ValidationResults.
		 * @return A list of ValidationResults.
		 */
		function resultsAsArray():Array;
		
		/**
		 * Return a list of error messages that have been added using the given key.
		 * @param key The key to filter with.
		 * @return A list of simple strings.
		 */
		function errorsByKey(key:String):ListCollectionView;
		
		/**
		 * Return a list of error messages that have been added using the given key, 
		 * transformed into ValidationResults.
		 * @return A list of ValidationResults.
		 */
		function resultsByKey(key:String):ListCollectionView;
		
		/**
		 * Return a list of error messages that have been added using the given key, 
		 * transformed into ValidationResults.
		 * @return A list of ValidationResults.
		 */
		function resultsAsArrayByKey(key:String):Array;
		
		/**
		 * Check if the given value is null. Add a default error message if it is.
		 * @param value The value to check.
		 * @param key An optional key to associate any error messages with.
		 */
		function isNull(value:Object, key:String=null): IValidationBuilder;
		
		/**
		 * Check if the given value is not null. Add a default error message if it is.
		 * @param value The value to check.
		 * @param key An optional key to associate any error messages with.
		 */
		function isNotNull(value:Object, key:String=null): IValidationBuilder;	
		
		/**
		 * Provides access to a range of standard validations for the given String.
		 * @param value The string to validate.
		 * @param key An optional key to associate any error messages with.
		 * @return A validation builder for strings.
		 */
		function string(value:String, key:String=null): IStringValidationBuilder;
		
		/**
		 * Provides access to a range of standard validations for the given Number.
		 * @param value The number to validate.
		 * @param key An optional key to associate any error messages with.
		 * @return A validation builder for numbers.
		 */
		function number(value:Number, key:String=null): INumberValidationBuilder;
		
		/**
		 * Provides access to a range of standard validations for the given Date.
		 * @param value The date to validate.
		 * @param key An optional key to associate any error messages with.
		 * @return A validation builder for dates.
		 */
		function date(value:Date, key:String=null): IDateValidationBuilder;
	}
}