package org.compaction.validation.impl {
	
	import mx.events.ValidationResultEvent;
	import mx.validators.IValidatorListener;
	import mx.validators.ValidationResult;
	
	import org.compaction.CompactMockitoTestCase;
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.IValidationBuilderFactory;
	import org.compaction.validation.IValidator;
	
	public class ValidatorAdapterTest extends CompactMockitoTestCase {
		private var _factory:IValidationBuilderFactory;
		private var _adapter:ValidatorAdapter;
		private var _builder:IValidationBuilder;
		private var _validator:IValidator;
		private var _listener:IValidatorListener;
		
		public function ValidatorAdapterTest() {
			super([IValidator, IValidationBuilderFactory, IValidationBuilder, IValidatorListener]);
		}
		
		override public function setUp():void {
			_factory = mock(IValidationBuilderFactory); 
			_builder = mock(IValidationBuilder);
			_listener = mock(IValidatorListener);
			_validator = mock(IValidator); 
			
			_adapter = new ValidatorAdapter();
			_adapter.validator = _validator
			_adapter.factory = _factory
			_adapter.attachListener(_listener);
			
			given(_factory.newBuilder()).willReturn(_builder);
		}
		public function testValidatingWithNoValidatorAssignedDoesNotThrowNPE(): void {
			_adapter.validator = null;
			_adapter.validate(new Object());
		}
		
		public function testValidatingNotNullObjectReturnsTrueIfValidatorIsValid(): void {
			given(_builder.hasNoErrors()).willReturn(true);
			assertEquals(true, _adapter.validate(new Object()));
		}
		public function testValidatingNotNullObjectReturnsFalseIfValidatorIsNotValid(): void {
			given(_builder.hasNoErrors()).willReturn(false);
			assertEquals(false, _adapter.validate(new Object()));
		}
		
		public function testValidatingNullObjectDoesNotInvokeValidator(): void {
			_adapter.validate(null);
			verify(never()).that(_validator.validate(any(), any()));
		}
		public function testValidatingNotNullObjectInvokesValidator(): void {
			given(_builder.hasNoErrors()).willReturn(true);
			var item:Object = new Object();
			_adapter.validate(item);
			verify().that(_validator.validate(item, _builder));
		}
		
		public function testListenerRecievesValidationSuccessNotification(): void {
			given(_builder.hasErrors()).willReturn(false);
			given(_builder.hasNoErrors()).willReturn(true);
			_adapter.validate(new Object());
			verify().that(_listener.validationResultHandler(argThatMatches(function(item:ValidationResultEvent): Boolean {
				return item.type == ValidationResultEvent.VALID;
			})));
		}
		
		public function testListenerDoesNotRecieveValidationSuccessNotificationIfRemoved(): void {
			_adapter.removeListener(_listener);
			given(_builder.hasErrors()).willReturn(false);
			given(_builder.hasNoErrors()).willReturn(true);
			_adapter.validate(new Object());
			verify(never()).that(_listener.validationResultHandler(any()));
		}
		
		public function testListenerRecievesValidationFailureNotification(): void {
			given(_builder.hasErrors()).willReturn(true);
			given(_builder.hasNoErrors()).willReturn(false);
			_adapter.validate(new Object());
			verify().that(_listener.validationResultHandler(argThatMatches(function(item:ValidationResultEvent): Boolean {
				return item.type == ValidationResultEvent.INVALID;
			})));
		}
		
		public function testListenerDoesNotRecieveValidationFailureNotificationIfRemoved(): void {
			_adapter.removeListener(_listener);
			given(_builder.hasErrors()).willReturn(true);
			given(_builder.hasNoErrors()).willReturn(false);
			_adapter.validate(new Object());
			verify(never()).that(_listener.validationResultHandler(any()));
		}
		
		public function testListenerRecievesResultsOnNotification(): void {
			var results:Array = [new ValidationResult(false)];
			given(_builder.resultsAsArray()).willReturn(results);
			_adapter.validate(new Object());
			verify().that(_listener.validationResultHandler(argThatMatches(function(item:ValidationResultEvent): Boolean {
				return item.results == results;
			})));
		}
		
		public function testKeyedListenerRecievesFilteredResultsOnNotification(): void {
			_adapter.removeListener(_listener);
			_adapter.attachListener(_listener, "key");
			var results:Array = [new ValidationResult(false)];
			given(_builder.resultsAsArrayByKey("key")).willReturn(results);
			_adapter.validate(new Object());
			verify().that(_listener.validationResultHandler(argThatMatches(function(item:ValidationResultEvent): Boolean {
				return item.results == results;
			})));
		}
	}
}