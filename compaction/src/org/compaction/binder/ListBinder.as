package org.compaction.binder {
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.listClasses.ListBase;
	import mx.events.ListEvent;
	
	import org.compaction.action.IItemAction;
	
	public class ListBinder implements IBinder {
		private var _source:IItemAction;
		private var _target:ListBase;
		
		private var _enabledWatcher:ChangeWatcher;
		private var _tooltipWatcher:ChangeWatcher;
		
		public function set source(source:IItemAction): void {
			release();
			_source = source;
			bind();
		}
		public function set target(target:ListBase): void {
			release();
			_target = target;
			bind();
		}
		public function bind(): void {
			if(_source && _target) {
				_enabledWatcher = BindingUtils.bindProperty(_target, "enabled", _source, "available");
				_tooltipWatcher = BindingUtils.bindProperty(_target, "toolTip", _source, "messagesAsTooltip");
				_target.addEventListener(ListEvent.CHANGE, selectionListener);
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
				_target.removeEventListener(ListEvent.CHANGE, selectionListener);
			}
		}
		private function selectionListener(e:ListEvent): void {
			_source.execute(_target.selectedItem);
		}
	}
}