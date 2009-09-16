package org.compaction.binder {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Form;
	import mx.controls.Button;
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
	 * </ul>
	 * 
	 * @author shanonmcquay
	 */
	public class FormBinder {
		public var binderFactory:BinderFactory = new BinderFactory();
		private var _source:IEditModel;
		private var _target:Form;
		public function set source(source:IEditModel): void {
			_source = source;
			bindSourceToTarget();
		}
		public function set target(target:Form): void {
			_target = target;
			bindSourceToTarget();
		}
		private function bindSourceToTarget(): void {
			if(_source && _target) {
				if(_target.initialized) {
					bindInitializedSourceToTarget();
				} else {
					_target.addEventListener(FlexEvent.CREATION_COMPLETE, bindInitializedSourceToTarget);
				}
			}
		}
		private function bindInitializedSourceToTarget(e:Event=null): void {
			_target.removeEventListener(FlexEvent.CREATION_COMPLETE, bindInitializedSourceToTarget);
			
			var binder:ConditionBinder = binderFactory.newConditionBinder();
			binder.source = _source.editing;
			binder.target = _target;
			
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
				examineDateField(DateField(item));
			} else if(item is Button) {
				examineButton(Button(item));
			}
		}
		private function examineTextInput(item:TextInput): void {
			if(isInputField(item)) {
				var binder:TextBinder = binderFactory.newTextBinder();
				binder.source = _source;
				binder.property = "edited." + getInputFieldProperty(item);
				binder.target = item;
				bindValidationToInput(item);
			}
		}
		private function examineDateField(item:DateField): void {
			if(isInputField(item)) {
				var binder:DateBinder = binderFactory.newDateBinder();
				binder.source = _source;
				binder.property = "edited." + getInputFieldProperty(item);
				binder.target = item;
				bindValidationToInput(item);
			}
		}
		private function isInputField(item:UIComponent): Boolean {
			return StringUtils.endsWith(item.id, "Input");
		}
		private function getInputFieldProperty(item:UIComponent): String {
			return StringUtils.everythingBefore(item.id, "Input");
		}
		private function bindValidationToInput(item:UIComponent): void {
			var val:ValidationBinder = binderFactory.newValidationBinder();
			val.source = _source.adapter;
			val.key = getInputFieldProperty(item);
			val.target = item;
		}
		private function examineButton(item:Button): void {
			var binder:ActionBinder = binderFactory.newActionBinder();
			if("saveButton" == item.id) {
				binder.source = _source.save;
				binder.target = item;
			}
			else if("cancelButton" == item.id) {
				binder.source = _source.cancel;
				binder.target = item;
			}
		}
	}
}