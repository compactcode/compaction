package org.compaction.validation.impl {
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
	}
}