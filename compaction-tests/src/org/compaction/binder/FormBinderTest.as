package org.compaction.binder {
	import mx.containers.Form;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.DateField;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	
	import org.compaction.model.EditModel;
	import org.compaction.model.IEditModel;
	import org.mockito.MockitoTestCase;
	
	public class FormBinderTest extends MockitoTestCase {
		private var _binder:FormBinder;
		private var _source:IEditModel;
		private var _target:Form;
		private var _factory:BinderFactory;
		private var _actionBinder:ActionBinder;
		private var _dateBinder:DateBinder;
		private var _textBinder:TextBinder;
		private var _validationBinder:ValidationBinder;
		private var _conditionBinder:ConditionBinder;
		public function FormBinderTest() {
			super([ActionBinder, ConditionBinder, DateBinder, TextBinder, ValidationBinder, BinderFactory]);
		}
		override public function setUp():void {
			_source = new EditModel();
			_target = new Form();
			_target.initialized = true;
			
			_factory = mock(BinderFactory);
			_actionBinder = mock(ActionBinder);
			_conditionBinder = mock(ConditionBinder);
			_dateBinder = mock(DateBinder);
			_textBinder = mock(TextBinder);
			_validationBinder = mock(ValidationBinder);
			
			given(_factory.newActionBinder()).willReturn(_actionBinder);
			given(_factory.newConditionBinder()).willReturn(_conditionBinder);
			given(_factory.newDateBinder()).willReturn(_dateBinder);
			given(_factory.newTextBinder()).willReturn(_textBinder);
			given(_factory.newValidationBinder()).willReturn(_validationBinder);
			
			_binder = new FormBinder();
			_binder.binderFactory = _factory;
		}
		public function testSettingSourceDoesNothing(): void {
			_binder.source = _source;
		}
		public function testSettingTargetDoesNothing(): void {
			_binder.target = _target;
		}
		public function testFormButtonWithIdMatchingSaveButtonIsBound(): void {
			var button:Button = button("saveButton");
			_target.addChild(button);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_actionBinder.source = _source.save);
			verify().that(_actionBinder.target = button);
		}
		public function testFormButtonWithIdMatchingCancelButtonIsBound(): void {
			var button:Button = button("cancelButton");
			_target.addChild(button);
			
			_binder.target = _target;
			_binder.source = _source;
			
			verify().that(_actionBinder.source = _source.cancel);
			verify().that(_actionBinder.target = button);
		}
		public function testNestedFormTextInputWithIdMatchingModelPropertyIsBound(): void {
			var nestedInput:TextInput = textField("nameInput");
			var nested:HBox = new HBox();
			nested.addChild(nestedInput);
			_target.addChild(nested);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_textBinder.source = _source);
			verify().that(_textBinder.property = "edited.name");
			verify().that(_textBinder.target = nestedInput);
		}
		public function testFormTextInputWithIdIsBound(): void {
			var input:TextInput = textField("nameInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_textBinder.source = _source);
			verify().that(_textBinder.property = "edited.name");
			verify().that(_textBinder.target = input);
		}
		public function testFormTextInputWithIdIsBoundToValidator(): void {
			var input:TextInput = textField("nameInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_validationBinder.source = _source.adapter);
			verify().that(_validationBinder.key = "name");
			verify().that(_validationBinder.target = input);
		}
		public function testFormDateWithIdIsBound(): void {
			var input:DateField = dateField("birthInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_dateBinder.source = _source);
			verify().that(_dateBinder.property = "edited.birth");
			verify().that(_dateBinder.target = input);
		}
		public function testFormDateWithIdIsBoundToValidator(): void {
			var input:DateField = dateField("birthInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_validationBinder.source = _source.adapter);
			verify().that(_validationBinder.key = "birth");
			verify().that(_validationBinder.target = input);
		}
		public function testTargetIsBoundToEditingCondition(): void {
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_conditionBinder.source = _source.editing);
			verify().that(_conditionBinder.target = _target);
		}
		private function button(id:String):Button {
			return setId(id, new Button());
		}
		private function textField(id:String): TextInput {
			return setId(id, new TextInput());
		}
		private function dateField(id:String): DateField {
			return setId(id, new DateField());
		}
		private function setId(id:String, component:UIComponent): * {
			component.id = id;
			return component;
		}
	}
}