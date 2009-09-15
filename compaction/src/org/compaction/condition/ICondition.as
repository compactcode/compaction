package org.compaction.condition {
	/**
	 * A condition is really just a wrapper around boolean.
	 * 
	 * You can attach messages to both the true and false values of the condition.
	 * 
	 * @author shanonmcquay
	 */
	public interface ICondition {
		/**
		 * @return The current true/false value of the condition.
		 */
		function get currentValue():Boolean;
		/**
		 * Returns the false message if this condition is false.
		 * Returns the true message if this condition is true.
		 * @return The message for the current value of this condition.
		 */
		function get currentMessage(): String;
		/**
		 * Set the message that should be displayed when this condition is false.
		 * @param value The message to display.
		 */
		function set falseMessage(value:String):void;
		/**
		 * Set the message that should be displayed when this condition is true.
		 * @param value The message to display.
		 */
		function set trueMessage(value:String):void;
	}
}