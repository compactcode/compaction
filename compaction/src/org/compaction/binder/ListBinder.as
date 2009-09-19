package org.compaction.binder {
	import mx.binding.utils.BindingUtils;
	import mx.controls.listClasses.ListBase;
	import mx.events.ListEvent;
	
	import org.compaction.action.IItemAction;
	
	public class ListBinder {
		private var _source:IItemAction;
		private var _target:ListBase;
		public function set source(source:IItemAction): void {
			_source = source;
			refresh();
		}
		public function set target(target:ListBase): void {
			_target = target;
			refresh();
		}
		private function refresh(): void {
			if(_source && _target) {
				BindingUtils.bindProperty(_target, "enabled", _source, "available");
				BindingUtils.bindProperty(_target, "toolTip", _source, "messagesAsTooltip");
				_target.addEventListener(ListEvent.CHANGE, function(e:ListEvent): void {
					_source.execute(_target.selectedItem);
				});
			}
		}
	}
}