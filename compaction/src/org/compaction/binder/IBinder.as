package org.compaction.binder {
	/**
	 * A binder provides an interface for binding two objects together.
	 *  
	 * @author shanonmcquay
	 */
	public interface IBinder {
		/**
		 * Bind the objects together.
		 */
		function bind(): void;
		/**
		 * Remove all bindings/listeners created by the binder. 
		 */
		function release(): void;
	}
}