package org.compaction.validation.impl {
	import mx.validators.NumberValidator;
	
	import org.compaction.validation.INumberValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class NumberValidationBuilder extends AbstractValidationBuilder implements INumberValidationBuilder {
		public function NumberValidationBuilder(value:Number, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function between(min:Number, max:Number): INumberValidationBuilder {
			if(routines.lessThan(min, value)) {
				addError(messages.mustNotPrecedeMin(min));
			} else if(routines.greaterThan(max, value)) {
				addError(messages.mustNotExceedMax(max));
			}
			return this;
		}
		public function lessThan(max:int): INumberValidationBuilder {
			if(routines.greaterThanEqualTo(max, value)) {
				addError(messages.mustNotExceedMax(max));
			}
			return this;
		}
		public function greaterThan(min:int): INumberValidationBuilder {
			if(routines.lessThanEqualTo(min, value)) {
				addError(messages.mustNotPrecedeMin(min));
			}
			return this;
		}
	}
}