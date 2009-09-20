package org.compaction.binder {
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;
	
	import org.compaction.utils.ObjectUtils;
	
	public class BooleanBinder extends AbstractInputBinder {
		private var _target:CheckBox;
		public function set target(target:CheckBox): void {
			_target = target;
			bindSourceToTarget();
		}
		override public function bindSourceToTarget(): void {
			if(_source && _property && _target) {
				bind(_source, _property.split("."), _commitType, _target);
			}
		}
		public static function bind(source:Object, property:Array, commitType:String, target:CheckBox): void {
			BindingUtils.bindProperty(target, "selected", source, property);
			target.addEventListener(commitType, function(e:Event): void {
				ObjectUtils.setValueToHost(source, property, target.selected);
			});
		}
	}
}