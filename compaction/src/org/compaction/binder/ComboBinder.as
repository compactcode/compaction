package org.compaction.binder {
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.ComboBox;
	
	import org.compaction.utils.ObjectUtils;
	
	public class ComboBinder extends AbstractInputBinder {
		private var _target:ComboBox;
		public function set target(target:ComboBox): void {
			_target = target;
			bindSourceToTarget();
		}
		override public function bindSourceToTarget(): void {
			if(_source && _property && _target) {
				bind(_source, _property.split("."), _commitType, _target);
			}
		}
		public static function bind(source:Object, property:Array, commitType:String, target:ComboBox): void {
			BindingUtils.bindProperty(target, "selectedItem", source, property);
			target.addEventListener(commitType, function(e:Event): void {
				ObjectUtils.setValueToHost(source, property, target.selectedItem);
			});
		}
	}
}