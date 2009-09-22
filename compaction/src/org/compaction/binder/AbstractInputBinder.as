package org.compaction.binder {
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	
	import org.compaction.utils.ObjectUtils;
	
	/**
	 * Some common code for dealing with two way binding of user input.
	 * 
	 * @author shanonmcquay
	 */
	public class AbstractInputBinder implements IBinder{
		
		protected var _source:Object;
		protected var _property:String;
		protected var _commitEvent:String = Event.CHANGE;
		protected var _target:UIComponent;
		
		protected var _watcher:ChangeWatcher;
		
		public function set source(source:Object): void {
			unbindSourceFromTarget();
			_source = source;
			bindSourceToTarget();
		}
		public function set property(property:String): void {
			unbindSourceFromTarget();
			_property = property;
			bindSourceToTarget();
		}
		public function set commitEvent(commitEvent:String): void {
			unbindSourceFromTarget();
			_commitEvent = commitEvent;
			bindSourceToTarget();
		}
		protected function setTarget(target:UIComponent): void {
			unbindSourceFromTarget();
			_target = target;
			bindSourceToTarget();
		}
		public function bindSourceToTarget(): void {
			if(_source && _property && _target) {
				_watcher = BindingUtils.bindProperty(_target, targetPropertyName, _source, _property.split("."));
				_target.addEventListener(_commitEvent, commitListener);
			}
		}
		public function unbindSourceFromTarget(): void {
			if(_watcher) {
				_watcher.unwatch();
			}
			if(_target && _commitEvent) {
				_target.removeEventListener(_commitEvent, commitListener);
			}
		}
		protected function commitListener(e:Event): void {
			ObjectUtils.setValueToHost(_source, _property.split("."), targetPropertyValue);
		}
		protected function get targetPropertyName(): String {
			throw Error("Oops.");
		}
		protected function get targetPropertyValue(): Object {
			throw Error("Oops.");
		}
		
	}
}