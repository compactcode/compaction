package org.compaction.validation.impl {
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	
	public class AbstractValidationBuilder {
		private var _parent:IValidationBuilder;
		private var _value:*;
		private var _key:String;
		public function AbstractValidationBuilder(value:*, parent:IValidationBuilder, key:String=null) {
			_parent = parent;
			_value = value;
			_key = key;
		}
		public function get routines(): ValidationRoutines {
			return _parent.routines;
		}
		public function get messages(): ValidationMessages {
			return _parent.messages;
		}
		public function get value(): * {
			return _value;
		}
		public function addError(message:String): void {
			_parent.addError(message, _key);
		}
	}
}