package org.compaction.model {
	import mx.controls.listClasses.ListBase;
	import mx.rpc.AbstractOperation;
	
	import org.compaction.action.ISimpleAction;
	import org.compaction.condition.ICondition;
	
	public interface IListModel {
		function get selected():ICondition;
		
		function get load():ISimpleAction;
		
		function get list():Object;
		function set list(value:Object):void;
		
		function set loadOperation(value:AbstractOperation): void;
		function get loadOperation():AbstractOperation;
	}
}