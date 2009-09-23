package org.compaction.binder {
	import flash.events.FocusEvent;
	
	import mx.containers.Form;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
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
		private var _buttonBinder:ButtonBinder;
		private var _dateBinder:DateBinder;
		private var _booleanBinder:BooleanBinder;
		private var _comboBinder:ComboBinder;
		private var _textBinder:TextBinder;
		private var _validationBinder:ValidationBinder;
		private var _conditionBinder:ConditionBinder;
		public function FormBinderTest() {
			super([ButtonBinder, BooleanBinder, ConditionBinder, ComboBinder, DateBinder, TextBinder, ValidationBinder, BinderFactory]);
		}
		override public function setUp():void {
			_source = new EditModel();
			_target = new Form();
			_target.initialized = true;
			
			_factory = mock(BinderFactory);
			_buttonBinder = mock(ButtonBinder);
			_conditionBinder = mock(ConditionBinder);
			_dateBinder = mock(DateBinder);
			_booleanBinder = mock(BooleanBinder);
			_comboBinder = mock(ComboBinder);
			_textBinder = mock(TextBinder);
			_validationBinder = mock(ValidationBinder);
			
			given(_factory.newButtonBinder()).willReturn(_buttonBinder);
			given(_factory.newConditionBinder()).willReturn(_conditionBinder);
			given(_factory.newDateBinder()).willReturn(_dateBinder);
			given(_factory.newBooleanBinder()).willReturn(_booleanBinder);
			given(_factory.newComboBinder()).willReturn(_comboBinder);
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
			
			verify().that(_buttonBinder.source = _source.save);
			verify().that(_buttonBinder.target = button);
		}
		public function testFormButtonWithIdMatchingCancelButtonIsBound(): void {
			var button:Button = button("cancelButton");
			_target.addChild(button);
			
			_binder.target = _target;
			_binder.source = _source;
			
			verify().that(_buttonBinder.source = _source.cancel);
			verify().that(_buttonBinder.target = button);
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
		public function testFormCheckBoxWithIdIsBound(): void {
			var input:CheckBox = checkField("activeInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_booleanBinder.source = _source);
			verify().that(_booleanBinder.property = "edited.active");
			verify().that(_booleanBinder.target = input);
		}
		public function testFormCheckBoxWithIdIsBoundToValidator(): void {
			var input:CheckBox = checkField("activeInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_validationBinder.source = _source.adapter);
			verify().that(_validationBinder.key = "active");
			verify().that(_validationBinder.target = input);
		}
		public function testFormComboBoxWithIdIsBound(): void {
			var input:ComboBox = comboField("countryInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_comboBinder.source = _source);
			verify().that(_comboBinder.property = "edited.country");
			verify().that(_comboBinder.target = input);
		}
		public function testFormComboWithIdIsBoundToValidator(): void {
			var input:ComboBox = comboField("countryInput");
			_target.addChild(input);
			
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_validationBinder.source = _source.adapter);
			verify().that(_validationBinder.key = "country");
			verify().that(_validationBinder.target = input);
		}
		public function testCommitEventDefaultCanBeOverriden(): void {
			_target.addChild(comboField("fooInput"));
			_target.addChild(textField("fooInput"));
			_target.addChild(dateField("fooInput"));
			_target.addChild(checkField("fooInput"));
			
			_binder.source = _source;
			_binder.commitEvent = FocusEvent.FOCUS_OUT;
			_binder.target = _target;
			
			verify().that(_comboBinder.commitEvent = FocusEvent.FOCUS_OUT);
			verify().that(_textBinder.commitEvent = FocusEvent.FOCUS_OUT);
			verify().that(_dateBinder.commitEvent = FocusEvent.FOCUS_OUT);
			verify().that(_booleanBinder.commitEvent = FocusEvent.FOCUS_OUT);
		}
		public function testTargetIsBoundToEditingCondition(): void {
			_binder.source = _source;
			_binder.target = _target;
			
			verify().that(_conditionBinder.source = _source.editing);
			verify().that(_conditionBinder.target = _target);
		}
		public function testSaveButtonBinderCanBeUnbound(): void {
			_target.addChild(button("saveButton"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_buttonBinder.release());
		}
		public function testCancelButtonBinderCanBeUnbound(): void {
			_target.addChild(button("cancelButton"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_buttonBinder.release());
		}
		public function testValidationBinderCanBeUnbound(): void {
			_target.addChild(textField("fooInput"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_validationBinder.release());
		}
		public function testDateBinderCanBeUnbound(): void {
			_target.addChild(dateField("fooInput"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_dateBinder.release());
		}
		public function testTextBinderCanBeUnbound(): void {
			_target.addChild(textField("fooInput"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_textBinder.release());
		}
		public function testComboBinderCanBeUnbound(): void {
			_target.addChild(comboField("fooInput"));
			
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_comboBinder.release());
		}
		public function testConditionBinderCanBeUnbound(): void {
			_binder.source = _source;
			_binder.target = _target;
			
			_binder.release();
			
			verify().that(_conditionBinder.release());
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
		private function checkField(id:String): CheckBox {
			return setId(id, new CheckBox());
		}
		private function comboField(id:String): ComboBox {
			return setId(id, new ComboBox());
		}
		private function setId(id:String, component:UIComponent): * {
			component.id = id;
			return component;
		}
	}
}