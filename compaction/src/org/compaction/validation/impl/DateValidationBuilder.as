package org.compaction.validation.impl {
	import org.compaction.validation.IDateValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class DateValidationBuilder extends AbstractValidationBuilder implements IDateValidationBuilder {
		public function DateValidationBuilder(value:Date, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function onOrBeforeToday(): IDateValidationBuilder {
			if(routines.afterToday(value)) {
				addError(messages.wasAfterToday());
			}
			return this;
		}
		public function onOrBefore(max:Date): IDateValidationBuilder {
			if(routines.after(max, value)) {
				addError(messages.wasAfter(max));
			}
			return this;
		}
		public function onOrAfter(min:Date): IDateValidationBuilder {
			if(routines.before(min, value)) {
				addError(messages.wasBefore(min));
			}
			return this;
		}
	}
}