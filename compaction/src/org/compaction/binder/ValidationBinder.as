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
			release();
			_source = source;
			bind();
		}
		public function set target(target:IValidatorListener): void {
			release();
			_target = target;
			bind();
		}
		/**
		 * Restrict validation errors to the given validaiton key. 
		 * 
		 * @param key This key should match the key you are using in your IValidator.
		 */
		public function set key(key:String): void {
			release();
			_key = key
			bind();
		}
		public function bind():void {
			if(_source && _target) {
				_source.attachListener(_target, _key);
			}
		}
		public function release(): void {
			if(_source && _target) {
				_source.removeListener(_target);
			}
		}
	}
}