package org.compaction.model {
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.controls.listClasses.ListBase;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.ResultEvent;
	
	import org.compaction.action.ISimpleAction;
	import org.compaction.action.SimpleAction;
	import org.compaction.condition.Condition;
	import org.compaction.condition.ICondition;
	
	[ResourceBundle("compaction")]
	
	public class ListModel implements IListModel {
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private var _selected:Condition = new Condition(false);
		
		private var _load:SimpleAction;
		private var _loadOperation:AbstractOperation;
		
		private var _list:Object;
		
		public function ListModel() {
			_selected.falseMessage = _resourceManager.getString("compaction", "selectedFalse");
			_load = new SimpleAction(function(): void {
				_loadOperation.send();
			});
		}
		
		public function get selected():ICondition {
			return _selected;
		}
		
		public function get load():ISimpleAction {
			return _load;
		}
		
		public function get list():Object {
			return _list;
		}
		public function set list(value:Object):void {
			_list = value;
			if(_list.dataProvider == null) {
				_list.dataProvider = new ArrayCollection();
			}
			BindingUtils.bindSetter(updateSelectedCondition, _list, "selectedItem");
		}

		public function set loadOperation(value:AbstractOperation): void {
			_loadOperation = value;
			_loadOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					_list.dataProvider = event.result;
				}
			);
		}
		
		public function get loadOperation(): AbstractOperation {
			return _loadOperation;
		}
		
		private function updateSelectedCondition(selectedItem:Object): void {
			_selected.currentValue = !(selectedItem == null)
		}
	}
}