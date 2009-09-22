package org.compaction.binder {
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	
	import org.compaction.condition.ICondition;
	
	public class ConditionBinder implements IBinder {
		private var _source:ICondition;
		private var _target:UIComponent;
		
		private var _enabledWatcher:ChangeWatcher;
		private var _tooltipWatcher:ChangeWatcher;
		
		public function set source(source:ICondition): void {
			unbindSourceFromTarget();
			_source = source;
			bindSourceToTarget();
		}
		public function set target(target:UIComponent): void {
			unbindSourceFromTarget();
			_target = target;
			bindSourceToTarget();
		}
		public function bindSourceToTarget(): void {
			if(_source && _target) {
				_enabledWatcher = BindingUtils.bindProperty(_target, "enabled", _source, "currentValue");
				_tooltipWatcher = BindingUtils.bindProperty(_target, "toolTip", _source, "currentMessage");
			}
		}
		public function unbindSourceFromTarget(): void {
			if(_enabledWatcher) {
				_enabledWatcher.unwatch();
			}
			if(_tooltipWatcher) {
				_tooltipWatcher.unwatch();
			}
		}
	}
}