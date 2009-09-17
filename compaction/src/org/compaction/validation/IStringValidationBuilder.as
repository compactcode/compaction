package org.compaction.validation {
	public interface IStringValidationBuilder {
		function notEmpty(): IStringValidationBuilder;
		function minLength(limit:int): IStringValidationBuilder;
		function maxLength(limit:int): IStringValidationBuilder;
	}
}