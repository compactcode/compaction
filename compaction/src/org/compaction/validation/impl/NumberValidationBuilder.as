package org.compaction.validation.impl {
	import org.compaction.validation.INumberValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class NumberValidationBuilder extends AbstractValidationBuilder implements INumberValidationBuilder {
		public function NumberValidationBuilder(value:Number, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function between(min:Number, max:Number): INumberValidationBuilder {
			if(routines.lessThan(min, value)) {
				addError(messages.wasLowerThanMin());
			} else if(routines.greaterThan(max, value)) {
				addError(messages.wasGreaterThanMax());
			}
			return this;
		}
	}
}