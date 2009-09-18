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
		
		// -- Between
		
		public function testBetweenAddsErrorIfLessThanRoutineFails(): void {
			var min:int = 0;
			var max:int = 1;
			given(_routines.greaterThan(max, 1)).willReturn(false);
			given(_routines.lessThan(min, 1)).willReturn(true);
			given(_messages.wasLowerThanMin(min)).willReturn("lowerthan");
			_builder = new NumberValidationBuilder(1, _parent, "key");
			_builder.between(min, max);
			verify().that(_parent.addError("lowerthan", "key"));
		}
		public function testBetweenAddsErrorIfGreaterThanRoutineFails(): void {
			var min:int = 0;
			var max:int = 1;
			given(_routines.greaterThan(max, 1)).willReturn(true);
			given(_routines.lessThan(min, 1)).willReturn(false);
			given(_messages.wasGreaterThanMax(max)).willReturn("greaterthan");
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
			assertEquals(_builder, _builder.between(0,0));
		}
		
		// -- Less Than
		
		public function testLessThanAddsErrorIfRoutineFails(): void {
			given(_routines.greaterThanEqualTo(2, 2)).willReturn(true);
			given(_messages.wasGreaterThanMax(2)).willReturn("greaterthanmax");
			
			_builder = new NumberValidationBuilder(2, _parent, "key");
			_builder.lessThan(2);
			
			verify().that(_parent.addError("greaterthanmax", "key"));
		}
		public function testLessThanDoesNothingIfRoutinePasses(): void {
			given(_routines.greaterThanEqualTo(3, 2)).willReturn(false);
			
			_builder = new NumberValidationBuilder(2, _parent, "key");
			_builder.lessThan(3);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testLessThanIsFluent(): void {
			_builder = new NumberValidationBuilder(1, _parent, "key");
			assertEquals(_builder, _builder.lessThan(0));
		}
		
		// -- Greater Than
		
		public function testGreaterThanAddsErrorIfRoutineFails(): void {
			given(_routines.lessThanEqualTo(3, 3)).willReturn(true);
			given(_messages.wasLowerThanMin(3)).willReturn("lessthanmin");
			
			_builder = new NumberValidationBuilder(3, _parent, "key");
			_builder.greaterThan(3);
			
			verify().that(_parent.addError("lessthanmin", "key"));
		}
		public function testGreaterThanDoesNothingIfRoutinePasses(): void {
			given(_routines.lessThanEqualTo(2, 3)).willReturn(false);
			
			_builder = new NumberValidationBuilder(3, _parent, "key");
			_builder.greaterThan(2);
			
			verify(never()).that(_parent.addError(any(), any()));
		}
		public function testGreaterThanIsFluent(): void {
			_builder = new NumberValidationBuilder(0, _parent, "key");
			assertEquals(_builder, _builder.greaterThan(0));
		}
		
	}
}