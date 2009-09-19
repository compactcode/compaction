package org.compaction.validation.impl {
	import org.compaction.validation.IDateValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class DateValidationBuilder extends AbstractValidationBuilder implements IDateValidationBuilder {
		public function DateValidationBuilder(value:Date, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function beforeToday(): IDateValidationBuilder {
			if(value && !routines.beforeToday(value)) {
				addError(messages.mustBeBeforeToday());
			}
			return this;
		}
		public function before(max:Date): IDateValidationBuilder {
			if(value && !routines.before(max, value)) {
				addError(messages.mustBeBefore(max));
			}
			return this;
		}
		public function after(min:Date): IDateValidationBuilder {
			if(value && !routines.after(min, value)) {
				addError(messages.mustBeAfter(min));
			}
			return this;
		}
	}
}