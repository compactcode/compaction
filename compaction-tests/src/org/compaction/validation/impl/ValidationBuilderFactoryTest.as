package org.compaction.validation.impl {
	import flexunit.framework.TestCase;
	public class ValidationBuilderFactoryTest extends TestCase {
		public function testNewBuilderCreatesValidationBuilderImpl(): void {
			assertEquals(true, new ValidationBuilderFactory().newBuilder() is ValidationBuilder);
		}
	}
}