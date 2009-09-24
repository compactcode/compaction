package org.compaction.model {
	
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.compaction.BindableCustomer;
	import org.compaction.InvocationRecorder;
	import org.compaction.NonBindableCustomer;
	import org.compaction.SimulatedSaveStrategy;
	import org.compaction.StubItemOperation;
	import org.compaction.StubValidator;
	
	public class EditModelTest extends TestCase {
		private var _model:EditModel;
		
		override public function setUp():void {
			_model = new EditModel();
		}
		
		// --- Editing Condition
		
		public function testEditingFalseByDefault(): void {
			assertEquals(false, _model.editing.currentValue);
		}
		public function testEditingIsFalseAfterEditActionInvokedWithNullObject():void {
			_model.edit.execute(null);
			assertEquals(false, _model.editing.currentValue);
		}
		public function testEditingIsTrueAfterEditActionInvokedWithNotNullObject():void {
			_model.edit.execute(new BindableCustomer());
			assertEquals(true, _model.editing.currentValue);
		}
		public function testEditingIsFalseAfterEditingNotNullThenNullObject(): void {
			_model.edit.execute(new BindableCustomer());
			_model.edit.execute(null);
			assertEquals(false, _model.editing.currentValue);
		}
		
		// --- Editing And Accepting Input Condition
		
		public function testEditingAndAcceptingIsTrueWhenEditingAndNotSaving(): void {
			_model.setEditing(true);
			_model.setSaving(false);
			assertEquals(true, _model.editingAndAcceptingInput.currentValue);
		}
		public function testEditingAndAcceptingIsFalseWhenSaving(): void {
			_model.setEditing(true);
			_model.setSaving(true);
			assertEquals(false, _model.editingAndAcceptingInput.currentValue);
		}
		public function testEditingAndAcceptingIsFalseWhenNotEditing(): void {
			_model.setEditing(false);
			_model.setSaving(false);
			assertEquals(false, _model.editingAndAcceptingInput.currentValue);
		}
		
		// --- Changed Condition
		
		public function testChangedIsFalseByDefault(): void {
			assertEquals(false, _model.changed.currentValue);
		}
		public function testChangedIsTrueAfterMakingChangesToEditedObject(): void {
			var value:BindableCustomer = new BindableCustomer();
			_model.edit.execute(value);
			_model.edited.name = "shanon";
			assertEquals(true, _model.changed.currentValue);
		}
		public function testChangedIsFalseAfterReversingChangesToEditedObject(): void {
			var value:BindableCustomer = new BindableCustomer();
			value.name = "";
			_model.edit.execute(value);
			_model.edited.name = "shanon";
			_model.edited.name = "";
			assertEquals(false, _model.changed.currentValue);
		}
		public function testChangedIsFalseAfterCancelActionInvoked(): void {
			_model.setEditing(true);
			_model.setChanged(true);
			_model.cancel.execute();
			assertEquals(false, _model.changed.currentValue);
		}
		
		// --- Valid Condition
		
		public function testValidIsTrueByDefault(): void {
			assertEquals(true, _model.valid.currentValue);
		}
		public function testValidIsTrueAfterEditingNullObject(): void {
			_model.edit.execute(null);
			assertEquals(true, _model.valid.currentValue);
		}
		public function testValidIsTrueAfterEditingNotNullObject(): void {
			_model.edit.execute(new BindableCustomer());
			assertEquals(true, _model.valid.currentValue);
		}
		public function testValidIsTrueAfterMakingValidChangesToEditedObject(): void {
			_model.adapter.validator = new StubValidator(true);
			_model.edit.execute(new BindableCustomer());
			_model.edited.name = "shanon";
			assertEquals(true, _model.valid.currentValue);
		}
		public function testValidIsFalseAfterMakingInvalidChangesToEditedObject(): void {
			_model.adapter.validator = new StubValidator(false);
			_model.edit.execute(new BindableCustomer());
			_model.edited.name = "shanon";
			assertEquals(false, _model.valid.currentValue);
		}
		
		// --- Saving Condition
		
		public function testSavingIsTrueWhileStrategySaveIsExecuting(): void {
			_model.edit.execute(new BindableCustomer()); 
			_model.edited.name = "shanon";
			_model.saveOperation = new StubItemOperation(StubItemOperation.WAIT);
			_model.save.execute();
			assertEquals(true, _model.saving.currentValue);
		}
		
		public function testSavingIsFalseAfterStrategySaveSuccess(): void {
			_model.edit.execute(new BindableCustomer()); 
			_model.edited.name = "shanon";
			_model.saveOperation = new StubItemOperation(StubItemOperation.SUCCESS);
			_model.save.execute();
			assertEquals(false, _model.saving.currentValue);
		}
		
		public function testSavingIsFalseAfterStrategySaveFails(): void {
			_model.edit.execute(new BindableCustomer()); 
			_model.edited.name = "shanon";
			_model.saveOperation = new StubItemOperation(StubItemOperation.FAIL);
			_model.save.execute();
			assertEquals(false, _model.saving.currentValue);
		}
		
		// --- Edit Action Availability
		
		public function testEditActionIsAvailableByDefault(): void {
			assertEquals(true, _model.edit.available);
		}
		public function testEditActionIsUnavailableAfterChangingSavingToTrue(): void {
			_model.setSaving(true);
			assertEquals(false, _model.edit.available);
		}
		public function testEditActionIsAvailableAfterChangingSavingToFalse(): void {
			_model.setSaving(false);
			assertEquals(true, _model.edit.available);
		}
		public function testEditActionIsAvailableAfterChangingChangedToFalse(): void {
			_model.setChanged(false);
			assertEquals(true, _model.edit.available);
		}
		public function testEditActionIsUnavailableAfterChangingChangedToTrue(): void {
			_model.setChanged(true);
			assertEquals(false, _model.edit.available);
		}
		
		// --- Save Action Availability
		
		public function testSaveActionIsUnavailableByDefault(): void {
			assertEquals(false, _model.save.available);
		}
		public function testSaveActionIsUnavailableAfterChangingSavingToTrue(): void {
			_model.setSaving(true);
			assertEquals(false, _model.save.available);
		}
		public function testSaveActionIsAvailableAfterChangingChangedEditingAndValidToTrue(): void {
			_model.setEditing(true);
			_model.setChanged(true);
			_model.setValid(true);
			assertEquals(true, _model.save.available);
		}
		public function testSaveActionIsUnavailableAfterChangingSavingToTrueAndChangedAndEditingToTrue(): void {
			_model.setSaving(true);
			_model.setEditing(true);
			_model.setChanged(true);
			assertEquals(false, _model.save.available);
		}
		public function testSaveActionIsUnavailableAfterChangingChangedAndEditingToTrueAndValidToFalse(): void {
			_model.setEditing(true);
			_model.setChanged(true);
			_model.setValid(false);
			assertEquals(false, _model.save.available);
		}
				
		// --- Cancel Action Availability
		
		public function testCancelActionIsUnavailableByDefault(): void {
			assertEquals(false, _model.cancel.available);
		}
		public function testCancelActionIsUnavailableAfterChangingSavingToTrueChangedToFalse(): void {
			_model.setSaving(true);
			_model.setChanged(false);
			assertEquals(false, _model.cancel.available);
		}
		public function testCancelActionIsUnavailableAfterChangingSavingToTrueChangedToTrue(): void {
			_model.setChanged(true);
			_model.setSaving(true);
			assertEquals(false, _model.cancel.available);
		}
		public function testCancelActionIsUnavailableAfterChangingSavingToFalseChangedToFalse(): void {
			_model.setSaving(false);
			_model.setChanged(false);
			assertEquals(false, _model.cancel.available);
		}
		public function testCancelActionIsAvailableAfterChangingSavingToFalseEditingAndChangedToTrue(): void {
			_model.setSaving(false);
			_model.setEditing(true);
			_model.setChanged(true);
			assertEquals(true, _model.cancel.available);
		}
		
		// -- Edit Action Execution
		
		public function testEditingNonBindableObjectThrowsException(): void {
			try {
				_model.edit.execute(new NonBindableCustomer());
				fail();
			} catch (e:Error) {
				assertEquals("You can only edit bindable objects.", e.message);
			}
		}
	
		// -- Cancel Action Execution
		
		public function testCancelActionRevertsChangesToEditedObject(): void {
			var value:BindableCustomer = new BindableCustomer();
			_model.edit.execute(value);
			_model.edited.name = "shanon";
			_model.cancel.execute();
			assertEquals(null, value.name);
		}
		
		public function testCancelActionRevertChangesAreBindable(): void {
			var value:BindableCustomer = new BindableCustomer();
			_model.edit.execute(value);
			_model.edited.name = "shanon";
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(_model.edited, "name", recorder.invocationRecorder);
			_model.cancel.execute();
			assertEquals(1, recorder.invocationCount);
		}
		
		// -- Save Action Execution
		
		public function testSaveActionSetsChangedToFalseIfStrategyCompletesSuccessfully(): void {
			_model.edit.execute(new BindableCustomer()); 
			_model.edited.name = "shanon";
			_model.saveOperation = new StubItemOperation(StubItemOperation.SUCCESS);
			_model.save.execute();
			assertEquals(false, _model.changed.currentValue);
		}
		
		public function testSaveActionSetsChangedRemainsTrueIfStrategyCompletesUnsuccessfully(): void {
			_model.edit.execute(new BindableCustomer()); 
			_model.edited.name = "shanon";
			_model.saveOperation = new StubItemOperation(StubItemOperation.FAIL);
			_model.save.execute();
			assertEquals(true, _model.changed.currentValue);			
		}
		
		public function testChangesMadeDuringSaveActionAreBindableWhenStrategyCompletes(): void {
			var simulation:SimulatedSaveStrategy = new SimulatedSaveStrategy();
			_model.saveOperation = simulation;
			_model.edit.execute(new BindableCustomer());
			_model.edited.name = "shanon"; 
			_model.save.execute();
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(_model, "edited", recorder.invocationRecorder);
			simulation.simulateSuccess();
			assertEquals(1, recorder.invocationCount);
		}
		
		// -- Random
		
		public function testEditedObjectIsBindable(): void {
			var recorder:InvocationRecorder = new InvocationRecorder();
			ChangeWatcher.watch(_model, "edited", recorder.invocationRecorder);
			_model.edit.execute(new BindableCustomer());
			assertEquals(1, recorder.invocationCount);
		}
	}
}