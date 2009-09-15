package org.compaction.action {
	import mx.collections.ListCollectionView;
	import org.compaction.condition.ICondition;
	/**
	 * An action represents a user action that is designed to be bound to a flex control. 
	 * 
	 * @author shanonmcquay
	 */
	public interface IAction {
		/**
		 * Indicates if the action is currently available.
		 */
		function get available(): Boolean;
		/**
		 * A list of messages generated from the conditions assigned to the action.
		 */		
		function get messages(): ListCollectionView;
		/**
		 * A string representation of the action messages, ready to display as a tooltip. 
		 */
		function get messagesAsTooltip(): String;
		/**
		 * Indicates that the given condition must be true for the action to be available. 
		 */
		function availableWhenTrue(condition:ICondition): void;
		/**
		 * Indicates that the given condition must be false for the action to be available. 
		 */
		function availableWhenFalse(condition:ICondition): void;
	}
}