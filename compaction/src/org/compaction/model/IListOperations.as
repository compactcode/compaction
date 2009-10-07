package org.compaction.model {
	/**
	 * Responsible for performing potentially long running operations relating to a list.
	 * 
	 * @author shanonmcquay
	 */
	public interface IListOperations extends ISaveOperation {
		/**
		 * Retrieve the list.
		 * 
		 * @param onSuccess function(list:ListCollectionView): void
		 * @param onFail function(): void
		 */
		function find(onSuccess:Function, onFail:Function): void;
		/**
		 * Create a new object with the intention of adding it to the list with a subsequent save.
		 * 
		 * @param onSuccess function(item:Object): void
		 * @param onFail function(): void
		 */
		function create(onSuccess:Function, onFail:Function): void;
		/**
		 * Delete an existing object from the list.
		 * 
		 * @param item
		 * @param onSuccess
		 * @param onFail
		 */
		function destroy(item:Object, onSuccess:Function, onFail:Function): void;
	}
}