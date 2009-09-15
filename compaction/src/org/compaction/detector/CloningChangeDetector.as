package org.compaction.detector {
	
	import mx.utils.DescribeTypeCache;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	/**
	 * Uses a clone and compare technique to determine if a given object
	 * has changed. 
	 * 
	 * @author shanonmcquay
	 */
	public class CloningChangeDetector implements IChangeDetector {
		private var _before:Object;
		private var _now:Object;
		public function watch(object:Object):void {
			_before = ObjectUtil.copy(object);
			_now = object;
		}
		public function get changed():Boolean {
			return ObjectUtil.compare(_before, ObjectUtil.copy(_now)) != 0;
		}
		public function clear(): void {
			watch(_now);
		}
		public function revert():void {
			revertUntypedProperties(_now);
			revertTypedProperties(_now);
		}
		private function revertUntypedProperties(toRevert:Object):void {
			for(var property:String in _now) {
				toRevert[property] = _before[property];
			}
		}
		private function revertTypedProperties(toRevert:Object): void {
			var properties:XMLList = DescribeTypeCache.describeType(_now).typeDescription..accessor;
			for(var i:int; i < properties.length(); i++) {
				toRevert[properties[i].@name] = _before[properties[i].@name];
			}
		}
	}
}