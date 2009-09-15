package org.compaction.action {
	import flexunit.framework.TestCase;
	public class SimpleActionTest extends TestCase {
		public function testExecuteInvokesFunctionAssignedOnCreation(): void {
			var invoked:Boolean = false;
			var action:ISimpleAction = new SimpleAction(function(): void {invoked = true});
			action.execute();
			assertEquals(true, invoked);
		}
	}
}