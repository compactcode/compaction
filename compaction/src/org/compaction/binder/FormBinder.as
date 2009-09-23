package org.compaction.binder {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Form;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	import mx.controls.TextInput;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.compaction.model.IEditModel;
	import org.compaction.utils.StringUtils;
	
	/**
	 * Uses convention over configuration approach to bind an IEditModel to a flex Form.
	 * 
	 * The conventions are as follows:
	 * 
	 * <ul>
	 * <li>A Button with an id of 'saveButton' is bound to the model save action.</li>
	 * <li>A Button with an id of 'cancelButton' is bound to the model cancel action.</li>
	 * <li>A TextInput with an id of 'nameInput' is bound to the model edited object 'name' property.</li>
	 * <li>A TextInput with an id of 'nameInput' is bound to the model validator using the 'name' validation key.</li>
	 * <li>A DateField with an id of 'birthdayInput' is bound to the model edited object 'birthday' property.</li>
	 * <li>A DateField with an id of 'birthdayInput' is bound to the model validator using the 'birthday' validation key.</li>
	 * <li>A CheckBox with an id of 'activeInput' is bound to the model edited object 'active' property.</li>
	 * <li>A CheckBox with an id of 'activeInput' is bound to the model validator using the 'active' validation key.</li>
	 * <li>A ComboBox with an id of 'cityInput' is bound to the model edited object 'city' property.</li>
	 * <li>A ComboBox with an id of 'cityInput' is bound to the model validator using the 'city' validation key.</li>
	 * </ul>
	 * 
	 * @author shanonmcquay
	 */
	public class FormBinder implements IBinder {
		public var binderFactory:BinderFactory = new BinderFactory();
		private var _source:IEditModel;
		private var _commitEvent:String;
		private var _target:Form;
		private var _watchers:Array = [];
		public function set source(source:IEditModel): void {
			release();
			_source = source;
			bind();
		}
		public function set commitEvent(commitEvent:String): void {
			release();
			_commitEvent = commitEvent;
			bind();
		}
		public function set target(target:Form): void {
			release();
			_target = target;
			bind();
		}
		public function bind(): void {
			if(_source && _target) {
				if(_target.initialized) {
					bindInitializedSourceToTarget();
				} else {
					_target.addEventListener(FlexEvent.CREATION_COMPLETE, bindInitializedSourceToTarget);
				}
			}
		}
		public function release(): void {
			_watchers.forEach(function(item:IBinder, index:int, array:Array): void {
				item.release();
			});
			_watchers = [];
		}
		private function bindInitializedSourceToTarget(e:Event=null): void {
			_target.removeEventListener(FlexEvent.CREATION_COMPLETE, bindInitializedSourceToTarget);
			
			var binder:ConditionBinder = binderFactory.newConditionBinder();
			binder.source = _source.editingAndAcceptingInput;
			binder.target = _target;
			
			_watchers.push(binder);
			
			examineAllChildren(_target);
		}
		private function examineAllChildren(container:Container): void {
			container.getChildren().forEach(function(item:DisplayObject, index:int, array:Array): void {
				if(item is Container) {
					examineAllChildren(Container(item));
				} else {
					examineChild(item);
				}
			});
		}
		private function examineChild(item:DisplayObject): void {
			if(item is TextInput) {
				examineTextInput(TextInput(item));
			} else if(item is DateField) {
				examineDateInput(DateField(item));
			} else if(item is CheckBox) {
				examineCheckInput(CheckBox(item));
			} else if(item is ComboBox) {
				examineComboInput(ComboBox(item));
			} else if(item is Button) {
				examineButton(Button(item));
			}
		}
		private function examineCheckInput(item:CheckBox): void {
			if(isInputField(item)) {
				bindInputField(item, binderFactory.newBooleanBinder());
			}
		}
		private function examineTextInput(item:TextInput): void {
			if(isInputField(item)) {
				bindInputField(item, binderFactory.newTextBinder());
			}
		}
		private function examineDateInput(item:DateField): void {
			if(isInputField(item)) {
				bindInputField(item, binderFactory.newDateBinder());
			}
		}
		private function examineComboInput(item:ComboBox): void {
			if(isInputField(item)) {
				bindInputField(item, binderFactory.newComboBinder());
			}
		}
		private function isInputField(item:UIComponent): Boolean {
			return StringUtils.endsWith(item.id, "Input");
		}
		private function getInputFieldProperty(item:UIComponent): String {
			return StringUtils.everythingBefore(item.id, "Input");
		}
		private function examineButton(item:Button): void {
			var binder:ButtonBinder = binderFactory.newButtonBinder();
			if("saveButton" == item.id) {
				binder.source = _source.save;
				binder.target = item;
				_watchers.push(binder);
			}
			else if("cancelButton" == item.id) {
				binder.source = _source.cancel;
				binder.target = item;
				_watchers.push(binder);
			}
		}
		private function bindInputField(item:*, binder:*): void {
			binder.source = _source;
			binder.property = "edited." + getInputFieldProperty(item);
			if(_commitEvent) {
				binder.commitEvent = _commitEvent;
			}
			binder.target = item;
			_watchers.push(binder);
			bindValidationToInput(item);
		}
		private function bindValidationToInput(item:UIComponent): void {
			var binder:ValidationBinder = binderFactory.newValidationBinder();
			binder.source = _source.adapter;
			binder.key = getInputFieldProperty(item);
			binder.target = item;
			_watchers.push(binder);
		}
	}
}