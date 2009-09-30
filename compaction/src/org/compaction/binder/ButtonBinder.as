package org.compaction.binder {
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.Button;
	
	import org.compaction.action.ISimpleAction;
	
	/**
	 * Binds an ISimpleAction to a flex Button.
	 * 
	 * The button enabled property will be bound to the action availability.
	 * The button tooltip property will be bound to the action messagesAsTooltip.
	 * The button click event will trigger the action's execute function.
	 * 
	 * @author shanonmcquay
	 */
	public class ButtonBinder implements IBinder {
		private var _source:ISimpleAction;
		private var _target:Button;
		
		private var _enabledWatcher:ChangeWatcher;
		private var _tooltipWatcher:ChangeWatcher;
		
		public function set source(source:ISimpleAction): void {
			release();
			_source = source;
			bind();
		}
		public function set target(target:Button): void {
			release();
			_target = target;
			bind();
		}
		public function bind(): void {
			if(_source && _target) {
				_enabledWatcher = BindingUtils.bindProperty(_target, "enabled", _source, "available");
				_tooltipWatcher = BindingUtils.bindProperty(_target, "toolTip", _source, "messagesAsTooltip");
				_target.addEventListener(MouseEvent.CLICK, clickListener);
			}
		}
		public function release(): void {
			if(_enabledWatcher) {
				_enabledWatcher.unwatch();
			}
			if(_tooltipWatcher) {
				_tooltipWatcher.unwatch();
			}
			if(_target) {
				_target.removeEventListener(MouseEvent.CLICK, clickListener);
			}
		}
		private function clickListener(e:MouseEvent): void {
			_source.execute();
		}
	}
}