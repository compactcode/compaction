package org.compaction.model {
	import mx.controls.listClasses.ListBase;
	import mx.rpc.AbstractOperation;
	
	import org.compaction.action.ISimpleAction;
	import org.compaction.condition.ICondition;
	
	public interface IListEditModel extends IListModel {
		function get create():ISimpleAction;
		function get destroy():ISimpleAction;
		
		function get editModel():IEditModel;
		
		function set createOperation(value:AbstractOperation): void;
		function get createOperation():AbstractOperation;
		function set saveOperation(value:AbstractOperation): void;
		function get saveOperation():AbstractOperation;
		function set destroyOperation(value:AbstractOperation): void;
		function get destroyOperation():AbstractOperation;
	}
}