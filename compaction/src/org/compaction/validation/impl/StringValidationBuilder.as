package org.compaction.validation.impl {
	import mx.validators.EmailValidator;
	
	import org.compaction.validation.IStringValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class StringValidationBuilder extends AbstractValidationBuilder implements IStringValidationBuilder {
		public function StringValidationBuilder(value:String, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function notEmpty(): IStringValidationBuilder {
			if(routines.empty(value)) {
				addError(messages.wasRequired());
			}
			return this;
		}
		public function minLength(min:int): IStringValidationBuilder {
			if(value && routines.lessThan(min, value.length)) {
				addError(messages.wasLowerThanCharacterMin(min));
			}
			return this;
		}
		public function maxLength(max:int): IStringValidationBuilder {
			if(value && routines.greaterThan(max, value.length)) {
				addError(messages.wasGreaterThanCharacterMax(max));
			}
			return this;
		}
		public function validEmail(): IStringValidationBuilder {
			if(routines.notEmpty(value)) {
				if(!routines.contains("@", value)) {
					addError(messages.wasMissingAtSign());
				} else if(!routines.containsOccurances("@", value, 1)) {
					addError(messages.wasTooManyAtSigns());
				} else if(!routines.containsAnythingLeftOf("@", value)) {
					addError(messages.wasMissingUserName());
				} else if(!routines.containsTokensInOrder("@", ".", value)) {
					addError(messages.wasMissingPeriodInDomain());
				}
			}
			return this;
		}
	}
}