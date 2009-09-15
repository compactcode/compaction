package org.compaction.validation.impl {
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.IValidationBuilderFactory;
	public class ValidationBuilderFactory implements IValidationBuilderFactory {
		public function newBuilder(): IValidationBuilder {
			return new ValidationBuilder();
		}
	}
}