package org.compaction.binder {
	
	/**
	 * A factory for creating binders, created to simplify unit testing. 
	 * 
	 * @author shanonmcquay
	 */
	public class BinderFactory {
		public function newButtonBinder(): ButtonBinder {
			return new ButtonBinder();
		}
		public function newTextBinder(): TextBinder {
			return new TextBinder();
		}
		public function newDateBinder(): DateBinder {
			return new DateBinder();
		}
		public function newBooleanBinder(): BooleanBinder {
			return new BooleanBinder();
		}
		public function newValidationBinder(): ValidationBinder {
			return new ValidationBinder();
		}
		public function newConditionBinder(): ConditionBinder {
			return new ConditionBinder();
		}
	}
}