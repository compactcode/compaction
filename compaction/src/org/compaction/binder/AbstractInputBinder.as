package org.compaction.binder {
	
	import flash.events.Event;
	
	/**
	 * Some common code for dealing with two way binding of user input.
	 * 
	 * @author shanonmcquay
	 */
	public class AbstractInputBinder {
		protected var _source:Object;
		protected var _property:String;
		protected var _commitType:String = Event.CHANGE;
		public function set source(source:Object): void {
			_source = source;
			bindSourceToTarget();
		}
		public function set property(property:String): void {
			_property = property;
			bindSourceToTarget();
		}
		public function set commitEvent(commitEvent:String): void {
			_commitType = commitEvent;
			bindSourceToTarget();
		}
		public function bindSourceToTarget(): void {}
	}
}