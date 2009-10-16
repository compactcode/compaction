package org.compaction.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.compaction.action.IItemAction;
	import org.compaction.action.ISimpleAction;
	import org.compaction.action.ItemAction;
	import org.compaction.action.SimpleAction;
	import org.compaction.condition.AndCondition;
	import org.compaction.condition.Condition;
	import org.compaction.condition.ICondition;
	import org.compaction.condition.NotCondition;
	import org.compaction.detector.CloningChangeDetector;
	import org.compaction.detector.IChangeDetector;
	import org.compaction.validation.IValidator;
	import org.compaction.validation.IValidatorAdapter;
	import org.compaction.validation.impl.ValidatorAdapter;
	
	[ResourceBundle("compaction")]
	
	public class EditModel extends EventDispatcher implements IEditModel {
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private const _editing:Condition = new Condition(false);
		private const _changed:Condition = new Condition(false);
		private const _valid:Condition = new Condition(true);
		private const _saving:Condition = new Condition(false);
		private const _editingAndAcceptingInput:ICondition = new AndCondition(
			_editing, 
			new NotCondition(_saving)
		);
		
		private var _edited:Object;
		
		private var _edit:ItemAction;
		private var _save:SimpleAction;
		private var _cancel:SimpleAction;
		
		private var _changeDetector:IChangeDetector = new CloningChangeDetector();
		private var _saveOperation:AbstractOperation;
		private var _validatorAdapter:ValidatorAdapter = new ValidatorAdapter();
		
		public function EditModel() {
			saving.trueMessage = _resourceManager.getString("compaction", "savingTrue");
			editing.falseMessage = _resourceManager.getString("compaction", "editingFalse");
			changed.trueMessage = _resourceManager.getString("compaction", "changedTrue");
			changed.falseMessage = _resourceManager.getString("compaction", "changedFalse");
			valid.falseMessage = _resourceManager.getString("compaction", "validFalse");
			
			_edit = new ItemAction(function(item:Object): void {
				setEdited(item);
			});
			_edit.availableWhenFalse(saving);
			_edit.availableWhenFalse(changed);
			
			_cancel = new SimpleAction(function(): void {
				revertChanges();
			});
			_cancel.availableWhenFalse(saving);
			_cancel.availableWhenTrue(editing);
			_cancel.availableWhenTrue(changed);
			
			_save = new SimpleAction(function():void {
				setSaving(true);
				_saveOperation.send(_edited);
			});
			_save.availableWhenFalse(saving);
			_save.availableWhenTrue(editing);
			_save.availableWhenTrue(changed);
			_save.availableWhenTrue(valid);
		}
		
		public function set saveOperation(operation:AbstractOperation): void {
			_saveOperation = operation;
			_saveOperation.addEventListener(
				ResultEvent.RESULT,
				function(): void {setSaving(false); ignoreCurrentChanges();}
			);
			_saveOperation.addEventListener(
				FaultEvent.FAULT,
				function(): void {setSaving(false);}
			);
		}
		
		public function get saveOperation(): AbstractOperation {
			return _saveOperation;
		}
		
		public function set validator(validator:IValidator): void {
			_validatorAdapter.validator = validator;
		}
		
		public function get adapter() : IValidatorAdapter {
			return _validatorAdapter;
		}
		
		public function get edit():IItemAction {
			return _edit;
		}

		public function get save():ISimpleAction {
			return _save;
		}
		
		public function get cancel():ISimpleAction {
			return _cancel;
		}
		
		public function get editing():ICondition {
			return _editing;
		}
		
		public function get editingAndAcceptingInput(): ICondition {
			return _editingAndAcceptingInput;
		}
		
		public function get changed():ICondition {
			return _changed;
		}
		
		public function ignoreCurrentChanges(): void {
			setEdited(_edited);
		}
		
		public function get valid():ICondition {
			return _valid;
		}
		
		public function get saving():ICondition {
			return _saving;
		}
				
		[Bindable(event="editModelEditedChanged")]
		public function get edited(): * {
			return _edited;
		}
		
		internal function setSaving(value:Boolean): void {
			_saving.currentValue = value;
		}
		
		internal function setEditing(value:Boolean): void {
			_editing.currentValue = value;
		}
		
		internal function setChanged(value:Boolean): void {
			_changed.currentValue = value;
		}
		
		internal function setValid(value:Boolean): void {
			_valid.currentValue = value;
		}
		
		internal function setEdited(value:Object): void {
			if(_edited) {
				_edited.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, updatedChangedCondition);
				_edited.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, updatedValidCondition);
			}
			if(value) {
				try {
					value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, updatedChangedCondition);
					value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, updatedValidCondition);
				} catch (e:Error) {
					throw new Error(_resourceManager.getString("compaction", "bindableRequired"));
				}
			}
			_edited = value;
			
			setEditing(_edited != null);
			
			_changeDetector.watch(_edited);
			
			updatedChangedCondition();
			updatedValidCondition();
			
			dispatchEvent(new Event("editModelEditedChanged"));
		}
		
		private function updatedChangedCondition(e:PropertyChangeEvent=null): void {
			setChanged(_changeDetector.changed);
		}
		
		private function updatedValidCondition(e:PropertyChangeEvent=null): void {
			setValid(_validatorAdapter.validate(_edited));
		}
		
		private function revertChanges(): void {
			_changeDetector.revert();
			updatedChangedCondition();
		}
		
	}
}