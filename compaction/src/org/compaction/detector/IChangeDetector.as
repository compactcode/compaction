package org.compaction.detector {
	import mx.utils.ObjectProxy;
	/**
	 * Simple interface for observing changes in a given object.
	 * 
	 * @author shanonmcquay
	 */
	public interface IChangeDetector {
		function watch(object:Object):void;
		function clear():void;
		function revert():void;
		function get changed():Boolean;
	}
}