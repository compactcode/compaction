package org.compaction.validation.impl {
	import org.compaction.validation.IDateValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	public class DateValidationBuilder extends AbstractValidationBuilder implements IDateValidationBuilder {
		public function DateValidationBuilder(value:Date, parent:IValidationBuilder, key:String) {
			super(value, parent, key);
		}
		public function beforeToday(): IDateValidationBuilder {
			if(routines.afterToday(value)) {
				addError(messages.wasAfterToday());
			}
			return this;
		}
	}
}