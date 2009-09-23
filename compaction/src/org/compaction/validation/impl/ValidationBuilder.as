package org.compaction.validation.impl {
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	import mx.validators.ValidationResult;
	
	import org.compaction.utils.CollectionUtils;
	import org.compaction.utils.KeyValue;
	import org.compaction.validation.IDateValidationBuilder;
	import org.compaction.validation.INumberValidationBuilder;
	import org.compaction.validation.IStringValidationBuilder;
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	
	public class ValidationBuilder implements IValidationBuilder {
		
		private var _routines:ValidationRoutines = new ValidationRoutines();
		private var _messages:ValidationMessages = new ValidationMessages();
		
		[ArrayElementType("com.compactcode.utils.KeyValue")]
		private var _errors:ArrayCollection = new ArrayCollection();
		
		public function get routines(): ValidationRoutines {
			return _routines;
		}
		
		public function set routines(value:ValidationRoutines): void  {
			_routines = value;
		}		
		
		public function get messages(): ValidationMessages {
			return _messages;
		}
		
		public function set messages(value:ValidationMessages): void  {
			_messages = value;
		}
		
		public function addError(message:String, key:String=null): void {
			_errors.addItem(new KeyValue(key, message));
		}
		
		public function hasErrors(): Boolean {
			return !hasNoErrors();
		}
		
		public function hasNoErrors(): Boolean {
			return _errors.length == 0;
		}
		
		public function errors(): ListCollectionView {
			return extractErrors(_errors);
		}
		
		public function results():ListCollectionView {
			return CollectionUtils.map(errors(), mapErrorToResult);
		}
		
		public function resultsAsArray():Array {
			return results().toArray();
		}
		
		public function errorsByKey(key:String):ListCollectionView {
			return extractErrors(CollectionUtils.filter(_errors, function(keyValue:KeyValue): Boolean {
				return keyValue.key == key;
			}));
		}
		
		public function resultsByKey(key:String):ListCollectionView {
			return CollectionUtils.map(errorsByKey(key), mapErrorToResult);
		}
		
		public function resultsAsArrayByKey(key:String):Array {
			return resultsByKey(key).toArray();
		}
		
		public function isNull(value:Object, key:String=null): IValidationBuilder {
			if(routines.isNotNull(value)) {
				addError(messages.mustBeNull());
			}
			return this;
		}
		public function isNotNull(value:Object, key:String=null): IValidationBuilder {
			if(routines.isNull(value)) {
				addError(messages.mustNotBeNull());
			}
			return this;
		}
		
		public function string(value:String, key:String=null): IStringValidationBuilder {
			return new StringValidationBuilder(value, this, key);
		}
		public function number(value:Number, key:String=null): INumberValidationBuilder {
			return new NumberValidationBuilder(value, this, key);
		}
		public function date(value:Date, key:String=null): IDateValidationBuilder {
			return new DateValidationBuilder(value, this, key);
		}
		
		private function extractErrors(collection: ListCollectionView): ListCollectionView {
			return CollectionUtils.map(collection, function(keyValue:KeyValue): String {
				return keyValue.value;
			});
		}
		
		private function mapErrorToResult(message:String): ValidationResult {
			return new ValidationResult(true, null, null, message);
		}
	}
}