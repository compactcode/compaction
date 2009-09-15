package org.compaction.model {
	/**
	 * A save strategy is responsible for persisting or processing changes made to an edited object.
	 * 
	 * @author shanonmcquay
	 */
	public interface ISaveStrategy {
		/**
		 * Save the given object.
		 * 
		 * @param item The item to save.
		 * @param onSuccess Call this when your done.
		 * @param onFail Call this when your done.
		 */
		function save(item:Object, onSuccess:Function, onFail:Function): void;
	}
}