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
			release();
			_source = source;
			bind();
		}
		public function set property(property:String): void {
			release();
			_property = property;
			bind();
		}
		public function set commitEvent(commitEvent:String): void {
			release();
			_commitEvent = commitEvent;
			bind();
		}
		protected function setTarget(target:UIComponent): void {
			release();
			_target = target;
			bind();
		}
		public function bind(): void {
			if(_source && _property && _target) {
				_watcher = BindingUtils.bindProperty(_target, targetPropertyName, _source, _property.split("."));
				_target.addEventListener(_commitEvent, commitListener);
			}
		}
		public function release(): void {
			if(_watcher) {
				_watcher.unwatch();
			}
			if(_target && _commitEvent) {
				_target.removeEventListener(_commitEvent, commitListener);
			}
		}
		protected function commitListener(e:Event): void {
			ObjectUtils.setValueToHost(_source, _property.split("."), _target[targetPropertyName]);
		}
		protected function get targetPropertyName(): String {
			throw Error("Oops.");
		}
	}
}