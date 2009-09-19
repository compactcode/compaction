package org.compaction.binder {
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Button;
	
	import org.compaction.action.ISimpleAction;
	
	/**
	 * Binds an ISimpleAction to a flex Button.
	 * 
	 * The button enabled property will be bound to the action availability.
	 * The button tooltip property will be bound to the action messagesAsTooltip.
	 * The button click event will trigger the action's execute funciton.
	 * 
	 * @author shanonmcquay
	 */
	public class ButtonBinder {
		private var _source:ISimpleAction;
		private var _target:Button;
		public function set source(source:ISimpleAction): void {
			_source = source;
			refresh();
		}
		public function set target(target:Button): void {
			_target = target;
			refresh();
		}
		private function refresh(): void {
			if(_source && _target) {
				BindingUtils.bindProperty(_target, "enabled", _source, "available");
				BindingUtils.bindProperty(_target, "toolTip", _source, "messagesAsTooltip");
				_target.addEventListener(MouseEvent.CLICK, function(e:MouseEvent): void {
					_source.execute();
				});
			}
		}
	}
}