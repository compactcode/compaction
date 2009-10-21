package org.compaction.model {
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	import mx.controls.DataGrid;
	
	import org.compaction.BindableCustomer;
	import org.compaction.StubOperation;
	
	public class ListModelTest extends TestCase {
		private var _model:ListEditModel;
		
		override public function setUp():void {
			_model = new ListEditModel();
			_model.list = createList([]);
		}
		
		// --- Selected Condition
		
		public function testSelectedFalseByDefault(): void {
			assertEquals(false, _model.selected.currentValue);
		}
		
		public function testSelectedTrueWhenListHasSelectedItem(): void {
			_model.list = createList(["a", "b"]);
			_model.list.selectedItem = "a";
			assertEquals(true, _model.selected.currentValue);
		}
		
		// --- Find Action Availability
		
		public function testFindAvailableByDefault(): void {
			assertEquals(true, _model.load.available);
		}
		
		public function testFindUnavailableWhenEditModelHasChanges(): void {
			_model.editModel.edit.execute(new BindableCustomer());
			_model.editModel.edited.name = "fred";
			assertEquals(false, _model.load.available);
		}
		
		// --- Create Action Availability
		
		public function testCreateAvailableByDefault(): void {
			assertEquals(true, _model.create.available);
		}
		
		public function testCreateUnavailableWhenEditModelHasChanges(): void {
			_model.editModel.edit.execute(new BindableCustomer());
			_model.editModel.edited.name = "fred";
			assertEquals(false, _model.create.available);
		}
		
		// --- Destroy Action Availability
		
		public function testDestroyUnavailableByDefault(): void {
			assertEquals(false, _model.destroy.available);
		}
		
		public function testDestroyUnavailableWhenEditModelHasChanges(): void {
			_model.editModel.edit.execute(new BindableCustomer());
			_model.editModel.edited.name = "fred";
			assertEquals(false, _model.destroy.available);
		}
		
		// -- Find Action Execution
		
		public function testFindInvokesFindOperationAndAssignsResultsToListDataProvider(): void {
			var findResults:ArrayCollection = new ArrayCollection(["a"]);
			_model.list = createList([]);
			_model.loadOperation = new StubOperation(StubOperation.SUCCESS, findResults);
			_model.load.execute();
			assertEquals(findResults, _model.list.dataProvider);
		}
		
		// -- Create Action Execution
		
		public function testCreateSuccessAssignsResultToEditModel(): void {
			var createResult:BindableCustomer = new BindableCustomer();
			_model.createOperation = new StubOperation(StubOperation.SUCCESS, createResult);
			_model.create.execute();
			assertEquals(createResult, _model.editModel.edited);
		}
		
		public function testCreateSuccessRemovesSelectionFromList(): void {
			_model.list = createList(["a"]);
			_model.list.selectedItem = "a";
			_model.createOperation = new StubOperation(StubOperation.SUCCESS);
			_model.create.execute();
			assertEquals(null, _model.list.selectedItem);
		}
		
		// -- Save Action Execution
		
		public function testSaveSuccessAddsCurrentlyEditedNewItemToList(): void {
			_model.editModel.edit.execute(new BindableCustomer());
			_model.editModel.edited.name = "fred";
			_model.saveOperation = new StubOperation(StubOperation.SUCCESS); 
			_model.editModel.save.execute();
			assertEquals(1, _model.list.dataProvider.length);
		}
		
		public function testSaveSuccessDoesNotAddCurrentlyEditedExistingItemToList(): void {
			_model.editModel.edit.execute(new BindableCustomer());
			_model.editModel.edited.name = "fred";
			_model.saveOperation = new StubOperation(StubOperation.SUCCESS); 
			_model.list = createList([_model.editModel.edited]);
			_model.editModel.save.execute();
			assertEquals(1, _model.list.dataProvider.length);
		}
		
		// -- Destroy Action Execution
		
		public function testDestroySuccessRemovesSelectedItemFromList(): void {
			_model.list = createList(["a"]);
			_model.list.selectedItem = "a";
			_model.destroyOperation = new StubOperation(StubOperation.SUCCESS);
			_model.destroy.execute();
			assertEquals(0, _model.list.dataProvider.length);
		}
		
		// -- Random
		
		public function testAssigningListAssignsEmptyDataProviderIfNull(): void {
			_model.list = createEmptyList();
			assertTrue(_model.list.dataProvider is ListCollectionView);
		}
		
		private function createEmptyList():DataGrid {
			var list:DataGrid = new DataGrid();
			list.columns = [];
			list.initialize();
			return list;
		}
		private function createList(items:Array):DataGrid {
			var list:DataGrid = createEmptyList();
			list.dataProvider = new ArrayCollection(items);
			return list;
		}		
	}
}