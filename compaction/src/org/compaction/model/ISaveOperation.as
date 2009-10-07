package org.compaction.model {
	/**
	 * An item operation is responsible for performing a potentially long running 
	 * operation on a given object.
	 * 
	 * Examples include:
	 * 
	 * <ul>
	 * <li>Saving the object to a database.</li>
	 * <li>Deleting the object from a database.</li>
	 * </ul>
	 * 
	 * @author shanonmcquay
	 */
	public interface ISaveOperation {
		/**
		 * Perform the operation on the given object.
		 * 
		 * @param item The item the operation is to be performed on.
		 * @param onSuccess Call this to indicate the operation succeeded.
		 * @param onFail Call this to indicate the operation failed.
		 */
		function execute(item:Object, onSuccess:Function, onFail:Function): void;
	}
}