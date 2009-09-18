package org.compaction.validation {
	public interface IDateValidationBuilder {
		function onOrBeforeToday(): IDateValidationBuilder;
		function onOrBefore(max:Date): IDateValidationBuilder;
		function onOrAfter(min:Date): IDateValidationBuilder;
	}
}