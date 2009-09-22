package org.compaction.binder {
	/**
	 * A binder provides an interface for binding two objects together.
	 *  
	 * @author shanonmcquay
	 */
	public interface IBinder {
		/**
		 * Execute
		 */
		function bindSourceToTarget(): void;
		/**
		 * Release all resources held by the binder. 
		 */
		function unbindSourceFromTarget(): void;
	}
}