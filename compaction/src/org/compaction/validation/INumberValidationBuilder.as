package org.compaction.validation {
	public interface INumberValidationBuilder {
		function between(min:Number, max:Number): INumberValidationBuilder;
	}
}