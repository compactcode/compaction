package org.compaction.model {
	/**
	 * Responsible for performing a potentially long running save on a given object.
	 * 
	 * @author shanonmcquay
	 */
	public interface ISaveOperation {
		/**
		 * Perform the save on the given object.
		 * 
		 * @param item The item the save is to be performed on.
		 * @param onSuccess function(): void
		 * @param onFail function(): void
		 */
		function save(item:Object, onSuccess:Function, onFail:Function): void;
	}
}