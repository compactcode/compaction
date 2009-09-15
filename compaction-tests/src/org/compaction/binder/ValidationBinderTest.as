package org.compaction.binder {
	import mx.validators.IValidatorListener;
	
	import org.compaction.validation.IValidatorAdapter;
	import org.mockito.MockitoTestCase;
	
	public class ValidationBinderTest extends MockitoTestCase {
		private var _binder:ValidationBinder;
		private var _source:IValidatorAdapter;
		private var _target:IValidatorListener;
		public function ValidationBinderTest() {
			super([IValidatorListener, IValidatorAdapter]);
		}
		override public function setUp():void {
			_source = mock(IValidatorAdapter);
			_target = mock(IValidatorListener);
			
			_binder = new ValidationBinder();
		}
		public function testSettingSourceDoesNothing(): void {
			_binder.source = _source;
			verify(never()).that(_source.removeListener(any()));
			verify(never()).that(_source.attachListener(any(), any()));
		}
		public function testSettingTargetDoesNothing(): void {
			_binder.target = _target;
			verify(never()).that(_source.removeListener(any()));
			verify(never()).that(_source.attachListener(any(), any()));
		}
		public function testSettingSourceThenTargetAttachesTargetToSourceUsingNullKey(): void {
			_binder.source = _source;
			_binder.target = _target;
			verify().that(_source.attachListener(_target, null));
		}
		public function testSettingTargetThenSourceAttachesTargetToSourceUsingNullKey(): void {
			_binder.target = _target;
			_binder.source = _source;
			verify().that(_source.attachListener(_target, null));
		}
		public function testSecondAttachmentRemovesTheFirst(): void {
			var second:IValidatorListener = mock(IValidatorListener);
			_binder.source = _source;
			_binder.target = _target;
			_binder.target = second;
			verify().that(_source.removeListener(_target));
			verify().that(_source.attachListener(second, null));
		}
		public function testSettingKeyAfterSourceAndTargetRettachesTargetUsingNewKey(): void {
			_binder.source = _source;
			_binder.target = _target;
			_binder.key = "key";
			verify().that(_source.removeListener(_target));
			verify().that(_source.attachListener(_target, "key"));
		}
	}
}