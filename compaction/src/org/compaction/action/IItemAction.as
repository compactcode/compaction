package org.compaction.action {
	/**
	 * An item action is an action that is designed to be invoked on an object.
	 * 
	 * The most common example is invoking an action on the currently selected item from a list or table.
	 * 
	 * @author shanonmcquay
	 */
	public interface IItemAction extends IAction {
		function execute(item:Object): void;
	}
}