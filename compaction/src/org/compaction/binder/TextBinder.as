package org.compaction.binder {
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.TextInput;
	
	import org.compaction.utils.ObjectUtils;
	
	/**
	 * Creates a two way binding between an object property and a TextInput.
	 * 
	 * @author shanonmcquay
	 */
	public class TextBinder extends AbstractInputBinder {
		private var _target:TextInput;
		public function set target(target:TextInput): void {
			_target = target;
			bindSourceToTarget();
		}
		override public function bindSourceToTarget(): void {
			if(_source && _property && _target) {
				bind(_source, _property.split("."), _commitType, _target);
			}
		}
		public static function bind(source:Object, property:Array, commitType:String, target:TextInput): void {
			BindingUtils.bindProperty(target, "text", source, property);
			target.addEventListener(commitType, function(e:Event): void {
				ObjectUtils.setValueToHost(source, property, target.text);
			});
		}
	}
}