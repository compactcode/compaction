package org.compaction.action {
	/**
	 * A simple action is an action that requires no external input in order to be invoked.
	 * 
	 * @author shanonmcquay
	 */
	public interface ISimpleAction extends IAction {
		function beforeExecute(listener:Function): void;
		function execute(): void;
	}
}