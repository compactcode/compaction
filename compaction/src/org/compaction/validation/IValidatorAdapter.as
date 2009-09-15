package org.compaction.validation {
	import mx.validators.IValidatorListener;
	
	public interface IValidatorAdapter {
		function set validator(validator:IValidator): void;
		function validate(item:Object): Boolean;
		function attachListener(listener:IValidatorListener, key:String=null): void;
		function removeListener(listener:IValidatorListener): void;
	}
}