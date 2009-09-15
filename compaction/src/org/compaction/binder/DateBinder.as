package org.compaction.binder {
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.DateField;
	
	import org.compaction.utils.ObjectUtils;
	
	/**
	 * Creates a two way binding between an object property and a DateField.
	 * 
	 * @author shanonmcquay
	 */
	public class DateBinder extends AbstractInputBinder {
		private var _target:DateField;
		public function set target(target:DateField): void {
			_target = target;
			bindSourceToTarget();
		}
		override public function bindSourceToTarget(): void {
			if(_source && _property && _target) {
				bind(_source, _property.split("."), _commitType, _target);
			}
		}
		public static function bind(source:Object, property:Array, commitType:String, target:DateField): void {
			BindingUtils.bindProperty(target, "selectedDate", source, property);
			target.addEventListener(commitType, function(e:Event): void {
				ObjectUtils.setValueToHost(source, property, target.selectedDate);
			});
		}
	}
}