package org.compaction.action {
	import flexunit.framework.TestCase;
	public class ItemActionTest extends TestCase {
		public function testExecuteInvokesFunctionAssignedOnCreation(): void {
			var invoked:Boolean = false;
			var action:IItemAction = new ItemAction(function(item:Object): void {invoked = true});
			action.execute(null);
			assertEquals(true, invoked);
		}
	}
}