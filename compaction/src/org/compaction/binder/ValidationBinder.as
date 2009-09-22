package org.compaction.binder {
	
	import mx.validators.IValidatorListener;
	
	import org.compaction.validation.IValidatorAdapter;
	
	/**
	 * Binds an compaction IValidatorAdapter to a flex IValidatorListener.
	 * 
	 * @author shanonmcquay
	 */
	public class ValidationBinder implements IBinder {
		private var _source:IValidatorAdapter;
		private var _target:IValidatorListener;
		private var _key:String = null;
		public function set source(source:IValidatorAdapter): void {
			unbindSourceFromTarget();
			_source = source;
			bindSourceToTarget();
		}
		public function set target(target:IValidatorListener): void {
			unbindSourceFromTarget();
			_target = target;
			bindSourceToTarget();
		}
		/**
		 * Restrict validation errors to the given validaiton key. 
		 * 
		 * @param key This key should match the key you are using in your IValidator.
		 */
		public function set key(key:String): void {
			unbindSourceFromTarget();
			_key = key
			bindSourceToTarget();
		}
		public function bindSourceToTarget():void {
			if(_source && _target) {
				_source.attachListener(_target, _key);
			}
		}
		public function unbindSourceFromTarget(): void {
			if(_source && _target) {
				_source.removeListener(_target);
			}
		}
	}
}