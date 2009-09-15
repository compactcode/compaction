package org.compaction.validation.impl {
	
	import mx.collections.ArrayCollection;
	import mx.events.ValidationResultEvent;
	import mx.validators.IValidatorListener;
	
	import org.compaction.utils.CollectionUtils;
	import org.compaction.utils.KeyValue;
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.IValidationBuilderFactory;
	import org.compaction.validation.IValidator;
	import org.compaction.validation.IValidatorAdapter;
	
	public class ValidatorAdapter implements IValidatorAdapter {
		private var _factory:IValidationBuilderFactory = new ValidationBuilderFactory();
		private var _validator:IValidator;
		
		[ArrayElementType("com.compactcode.utils.KeyValue")]
		private var _listeners:ArrayCollection = new ArrayCollection();
		
		public function set validator(validator:IValidator): void {
			_validator = validator;
		}
		
		public function set factory(value:IValidationBuilderFactory): void  {
			_factory = value;
		}	
		
		public function validate(item:Object): Boolean {
			var builder:IValidationBuilder = _factory.newBuilder();
			if(_validator && item) {
				_validator.validate(item, builder);
			}
			notifyListeners(builder);
			return builder.hasNoErrors();
		}
		
		public function attachListener(listener:IValidatorListener, key:String=null): void {
			_listeners.addItem(new KeyValue(key, listener));
		}
		
		public function removeListener(listener:IValidatorListener): void {
			CollectionUtils.removeAll(_listeners, function(keyValue:KeyValue): Boolean {
				return keyValue.value == listener;
			});
		}
		
		private function notifyListeners(result:IValidationBuilder): void {
			var type:String = ValidationResultEvent.VALID;
			if(result.hasErrors()) {
				type = ValidationResultEvent.INVALID;
			}
			for each(var keyValue:KeyValue in _listeners) {
				var listener:IValidatorListener = keyValue.value;
				if(keyValue.key == null) {
					listener.validationResultHandler(createResultEvent(type, result.resultsAsArray()));
				} else {
					listener.validationResultHandler(createResultEvent(type, result.resultsAsArrayByKey(keyValue.key)));
				}
			}
		}
		
		private function createResultEvent(type:String, results:Array): ValidationResultEvent {
			return new ValidationResultEvent(type, false, false, null, results);
		}
	}
}