package org.compaction.validation.impl {
	
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.ValidationMessages;
	import org.compaction.validation.ValidationRoutines;
	import org.mockito.MockitoTestCase;
	
	public class NumberValidationBuilderTest extends MockitoTestCase {
		
		private var _builder:NumberValidationBuilder;
		private var _parent:IValidationBuilder;
		private var _routines:ValidationRoutines;
		private var _messages:ValidationMessages;
		
		public function NumberValidationBuilderTest() {
			super([IValidationBuilder, ValidationRoutines, ValidationMessages]);
		}
		
		override public function setUp():void {
			_parent = mock(IValidationBuilder);
			_routines = mock(ValidationRoutines);
			_messages = mock(ValidationMessages);
			
			given(_parent.routines).willReturn(_routines);
			given(_parent.messages).willReturn(_messages);
		}
		
		public function testBetweenAddsErrorIfLessThanRoutineFails(): void {
			var min:int = 0;
			var max:int = 1;
			given(_routines.greaterThan(max, 1)).willReturn(false);
			given(_routines.lessThan(min, 1)).willReturn(true);
			given(_messages.wasLowerThanMin()).willReturn("lowerthan");
			_builder = new NumberValidationBuilder(1, _parent, "key");
			_builder.between(min, max);
			verify().that(_parent.addError("lowerthan", "key"));
		}
		public function testBetweenAddsErrorIfGreaterThanRoutineFails(): void {
			var min:int = 0;
			var max:int = 1;
			given(_routines.greaterThan(max, 1)).willReturn(true);
			given(_routines.lessThan(min, 1)).willReturn(false);
			given(_messages.wasGreaterThanMax()).willReturn("greaterthan");
			_builder = new NumberValidationBuilder(1, _parent, "key");
			_builder.between(min, max);
			verify().that(_parent.addError("greaterthan", "key"));
		}
		public function testBetweenDoesNothingIfRoutinesPass(): void {
			var min:int = 0;
			var max:int = 1;
			given(_routines.greaterThan(max, 1)).willReturn(false);
			given(_routines.lessThan(min, 1)).willReturn(false);
			_builder = new NumberValidationBuilder(1, _parent, "key");
			_builder.between(min, max);
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testBetweenIsFluent(): void {
			_builder = new NumberValidationBuilder(1, _parent, "key");
			assertEquals(_builder, _builder.between(0,0))
		}
		
	}
}