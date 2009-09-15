package org.compaction.binder {
	
	import mx.validators.IValidatorListener;
	
	import org.compaction.validation.IValidatorAdapter;
	
	/**
	 * Binds an compaction IValidatorAdapter to a flex IValidatorListener.
	 * 
	 * @author shanonmcquay
	 */
	public class ValidationBinder {
		private var _source:IValidatorAdapter;
		private var _target:IValidatorListener;
		private var _key:String = null;
		public function set source(source:IValidatorAdapter): void {
			bindSourceToTarget(source, _target);
		}
		public function set target(target:IValidatorListener): void {
			bindSourceToTarget(_source, target);
		}
		/**
		 * Restrict validation errors to the given validaiton key. 
		 * 
		 * @param key This key should match the key you are using in your IValidator.
		 */
		public function set key(key:String): void {
			_key = key
			bindSourceToTarget(_source, _target);
		}
		private function bindSourceToTarget(newSource:IValidatorAdapter, newTarget:IValidatorListener):void {
			if(_source && _target) {
				_source.removeListener(_target);
			}
			_source = newSource;
			_target = newTarget;
			if(_source && _target) {
				_source.attachListener(_target, _key);
			}
		}
	}
}