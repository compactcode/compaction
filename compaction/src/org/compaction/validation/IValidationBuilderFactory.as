package org.compaction.validation {
	/**
	 * A factory for creating validation builders, created to simplify unit testing. 
	 * 
	 * @author shanonmcquay
	 */
	public interface IValidationBuilderFactory {
		function newBuilder(): IValidationBuilder;
	}
}