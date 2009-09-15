package org.compaction.detector {
	
	import flexunit.framework.TestCase;
	
	import org.compaction.BindableCustomer;

	public class CloningChangeDetectorTest extends TestCase {
		private var _detector:IChangeDetector;

		override public function setUp():void {
			_detector = new CloningChangeDetector();
		}

		public function testChangedReturnsFalseByDefault():void {
			assertEquals(false, _detector.changed);
		}

		public function testChangedReturnsFalseIfNothingChanged():void {
			var _watched:Object = new Object();
			_watched.name = "fred"
			_detector.watch(_watched);
			assertEquals(false, _detector.changed);
		}
		
		public function testChangedReturnsTrueIfNameChanged():void {
			var _watched:Object = new Object();
			_detector.watch(_watched);
			_watched.name = "fred"
			assertEquals(true, _detector.changed);
		}

		public function testChangedReturnsFalseIfNameChangeReversed():void {
			var _watched:Object = new Object();
			_watched.name = "fred"
			_detector.watch(_watched);
			_watched.name = "bob"
			_watched.name = "fred"
			assertEquals(false, _detector.changed);
		}
		
		public function testChangedReturnsFalseAfterClear(): void {
			var _watched:BindableCustomer = new BindableCustomer();
			_detector.watch(_watched);
			_watched.name = "fred"
			_detector.clear();
			assertEquals(false, _detector.changed);
		}
		
		public function testCanRevertNameChange(): void {
			var _watched:Object = new Object();
			_watched.name = "fred"
			_detector.watch(_watched);
			_watched.name = "bob"
			_detector.revert();
			assertEquals("fred", _watched.name);
		}

		public function testCanRevertNameChangeBackToNull(): void {
			var _watched:Object = new Object();
			_detector.watch(_watched);
			_watched.name = "bob"
			_detector.revert();
			assertEquals(null, _watched.name);
		}

		public function testCanDetectNoChangeOnTypedBindableObject():void {
			var _watched:BindableCustomer = new BindableCustomer();
			_detector.watch(_watched);
			assertEquals(false, _detector.changed);
		}

		public function testCanDetectChangeOnTypedBindableObject():void {
			var _watched:BindableCustomer = new BindableCustomer();
			_detector.watch(_watched);
			_watched.name = "fred"
			assertEquals(true, _detector.changed);
		}
		
		public function testCanRevertChangeOnTypedBindableObject(): void {
			var _watched:BindableCustomer = new BindableCustomer();
			_watched.name = "fred"
			_detector.watch(_watched);
			_watched.name = "bob"
			_detector.revert();
			assertEquals("fred", _watched.name);
		}
		
	}
}