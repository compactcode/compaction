package org.compaction.binder {
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	
	import org.compaction.condition.ICondition;
	
	public class ConditionBinder {
		private var _source:ICondition;
		private var _target:UIComponent;
		public function set source(source:ICondition): void {
			_source = source;
			refresh();
		}
		public function set target(target:UIComponent): void {
			_target = target;
			refresh();
		}
		private function refresh(): void {
			if(_source && _target) {
				BindingUtils.bindProperty(_target, "enabled", _source, "currentValue");
				BindingUtils.bindProperty(_target, "toolTip", _source, "currentMessage");
			}
		}
	}
}