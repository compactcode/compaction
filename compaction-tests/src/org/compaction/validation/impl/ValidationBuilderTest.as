package org.compaction.validation.impl {
	
	import mx.validators.ValidationResult;
	
	import org.compaction.utils.CollectionUtils;
	import org.compaction.validation.IDateValidationBuilder;
	import org.compaction.validation.INumberValidationBuilder;
	import org.compaction.validation.IStringValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	import org.mockito.MockitoTestCase;
	
	public class ValidationBuilderTest extends MockitoTestCase {
		private var _builder:ValidationBuilder;
		public function ValidationBuilderTest() {
			super([ValidationRoutines, ValidationMessages]);
		}
		override public function setUp():void {
			_builder = new ValidationBuilder();
			_builder.routines = mock(ValidationRoutines);
			_builder.messages = mock(ValidationMessages);
		}
		
		public function testErrorsByKeyFiltersErrorsUsingKey(): void {
			_builder.addError("foo");
			_builder.addError("bar", "keyone");
			_builder.addError("baz", "keytwo");
			assertEquals(1, _builder.errorsByKey("keyone").length);
			assertEquals(true, _builder.errorsByKey("keyone").contains("bar"));
		}
		
		public function testResultsByKeyContainsErrorsTransformedIntoValidationResults(): void {
			_builder.addError("foo");
			_builder.addError("bar", "keyone");
			_builder.addError("baz", "keytwo");
			assertTrue(CollectionUtils.contains(1, _builder.resultsByKey("keyone"), function(item:ValidationResult):Boolean {
				return item.isError == true && item.errorMessage == "bar";
			}));
		}
		
		public function testResultsAsArrayByKeyIsACopyOfResultsByKey(): void {
			_builder.addError("foo");
			_builder.addError("bar", "keyone");
			_builder.addError("baz", "keytwo");
			assertEquals(1, _builder.resultsAsArrayByKey("keyone").filter(function(item:Object, index:int, array:Array):Boolean {
				return item.isError == true && item.errorMessage == "bar";
			}).length);
		}
		
		public function testHasErrorsDefaultsToFalse(): void {
			assertEquals(false, _builder.hasErrors());
		}
		public function testHasNoErrorsDefaultsToFalse(): void {
			assertEquals(true, _builder.hasNoErrors());
		}
		public function testHasNoErrorObjectsByDefault(): void {
			assertEquals(0, _builder.errors().length);
		}
		
		public function testIsNullFailureGeneratesErrorMessage(): void {
			given(_builder.routines.isNull(null)).willReturn(false);
			given(_builder.messages.wasNull()).willReturn("fail");
			_builder.isNull(null);
			assertEquals(true, _builder.errors().contains("fail"));
		}
		public function testIsNullSuccessDoesNothing(): void {
			given(_builder.routines.isNull(null)).willReturn(true);
			_builder.isNull(null);
			assertEquals(0, _builder.errors().length);
		}
		public function testIsNullIsFluent(): void {
			assertEquals(_builder, _builder.isNull(null));
		}
		
		public function testIsNotNullFailureGeneratesErrorMessage(): void {
			given(_builder.routines.isNotNull(null)).willReturn(false);
			given(_builder.messages.wasNotNull()).willReturn("fail");
			_builder.isNotNull(null);
			assertEquals(true, _builder.errors().contains("fail"));
		}
		public function testIsNotNullSuccessDoesNothing(): void {
			given(_builder.routines.isNotNull(null)).willReturn(true);
			_builder.isNotNull(null);
			assertEquals(0, _builder.errors().length);
		}
		public function testIsNotNullIsFluent(): void {
			assertEquals(_builder, _builder.isNotNull(null));
		}
		
		public function testResultsContainsErrorsTransformedIntoValidationResults(): void {
			_builder.addError("foo");
			assertEquals(true, CollectionUtils.contains(1, _builder.results(), function(item:ValidationResult):Boolean {
				return item.isError == true && item.errorMessage == "foo";
			}));
		}
		public function testResultsAsArrayIsACopyOfResults(): void {
			_builder.addError("foo");
			assertEquals(1, _builder.resultsAsArray().filter(function(item:Object, index:int, array:Array):Boolean {
				return item.isError == true && item.errorMessage == "foo";
			}).length);
		}
		
		public function testStringReturnsBuilder(): void {
			assertEquals(true, _builder.string(null) is IStringValidationBuilder);
		}
		public function testNumberReturnsBuilder(): void {
			assertEquals(true, _builder.number(0) is INumberValidationBuilder);
		}
		public function testDateReturnsBuilder(): void {
			assertEquals(true, _builder.date(null) is IDateValidationBuilder);
		}
	}
}