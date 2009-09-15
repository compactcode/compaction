package org.compaction.utils {
	import flexunit.framework.TestCase;
	
	import org.compaction.BindableCustomer;
	
	public class ObjectUtilsTest extends TestCase {
		public function testSetValueToHostDoesNothingWhenHostIsNull(): void {
			ObjectUtils.setValueToHost(null, ["name"], null);
		}
		public function testSetValueToHostDoesNothingWhenPropertyIsNull(): void {
			ObjectUtils.setValueToHost(new BindableCustomer, null, null);
		}
		public function testSetValueToHostCanSetSimpleProperty(): void {
			var customer:BindableCustomer = new BindableCustomer();
			ObjectUtils.setValueToHost(customer, ["name"], "fred");
			assertEquals("fred", customer.name);
		}
		public function testSetValueToHostCanSetNestedProperty(): void {
			var customer:BindableCustomer = new BindableCustomer();
			customer.birth = new Date(2000, 1, 1);
			ObjectUtils.setValueToHost(customer, ["birth", "fullYear"], 2005);
			assertEquals(2005, customer.birth.fullYear);
		}
		public function testSetValueToHostDoesNothingWhenNestedHostIsNull(): void {
			var customer:BindableCustomer = new BindableCustomer();
			customer.spouse = null;
			ObjectUtils.setValueToHost(customer, ["spouse", "birth","fullYear"], null);
		}
		
		public function testGetValueFromHostReturnsNullWhenHostIsNull(): void {
			assertEquals(null, ObjectUtils.getValueFromHost(null, ["name"]));
		}
		public function testGetValueFromHostReturnsNullWhenPropertyIsNull(): void {
			var customer:BindableCustomer = new BindableCustomer();
			assertEquals(null, ObjectUtils.getValueFromHost(customer, null));
		}
		public function testGetValueFromHostCanGetSimpleProperty(): void {
			var customer:BindableCustomer = new BindableCustomer();
			customer.name = "fred";
			assertEquals("fred", ObjectUtils.getValueFromHost(customer, ["name"]));
		}
		public function testGetValueFromHostCanGetNestedProperty(): void {
			var customer:BindableCustomer = new BindableCustomer();
			customer.birth = new Date(2000, 1, 1);
			assertEquals(2000, ObjectUtils.getValueFromHost(customer, ["birth","fullYear"]));
		}
		public function testGetValueFromHostReturnsNullWhenNestedHostIsNull(): void {
			var customer:BindableCustomer = new BindableCustomer();
			customer.spouse = null;
			assertEquals(null, ObjectUtils.getValueFromHost(customer, ["spouse", "birth","fullYear"]));
		}
	}
}