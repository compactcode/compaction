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
	
	public class ListEditModel extends ListModel implements IListEditModel {
		
		private var _create:SimpleAction;
		private var _destroy:SimpleAction;
		
		private var _editModel:IEditModel;
		
		private var _findOperation:AbstractOperation;
		private var _createOperation:AbstractOperation;
		private var _destroyOperation:AbstractOperation;
		
		public function ListEditModel() {
			_editModel = new EditModel();
			
			load.availableWhenFalse(_editModel.changed);
			
			_create = new SimpleAction(function(): void {
				_createOperation.send();
			});
			_create.availableWhenFalse(_editModel.changed);
			
			_destroy = new SimpleAction(function(): void {
				_destroyOperation.send(list.selectedItem);
			});
			_destroy.availableWhenTrue(selected);
			_destroy.availableWhenFalse(_editModel.changed);
		}
		
		public function get create():ISimpleAction {
			return _create;
		}
		public function get destroy():ISimpleAction {
			return _destroy;
		}
		
		public function get editModel():IEditModel {
			return _editModel;
		}
		
		public function set createOperation(value:AbstractOperation): void {
			_createOperation = value;
			_createOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					_editModel.edit.execute(event.result);
					list.selectedItem = null;
				}
			);
		}
		
		public function set saveOperation(value:AbstractOperation): void {
			_editModel.saveOperation = value;
			_editModel.saveOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					if(!list.dataProvider.contains(_editModel.edited)) {
						list.dataProvider.addItem(_editModel.edited);
					}
				}
			);
		}
		
		public function set destroyOperation(value:AbstractOperation): void {
			_destroyOperation = value;
			_destroyOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					var itemIndex:int = list.dataProvider.getItemIndex(list.selectedItem);
					list.dataProvider.removeItemAt(itemIndex);
				}
			);
		}
		
		public function get createOperation(): AbstractOperation {
			return _createOperation;
		}
		public function get saveOperation(): AbstractOperation {
			return _editModel.saveOperation;
		}
		public function get destroyOperation(): AbstractOperation {
			return _destroyOperation;
		}
		
	}
}