package org.compaction {
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.IValidator;
	public class StubValidator implements IValidator {
		private var _valid:Boolean;
		public function StubValidator(valid:Boolean) {
			_valid = valid;
		}
		public function validate(item:Object, builder:IValidationBuilder): void {
			var value:Object = null;
			if(_valid) {
				value = new Object();
			}
			builder.isNotNull(value);
		}
	}
}