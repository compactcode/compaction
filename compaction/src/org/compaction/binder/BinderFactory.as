package org.compaction.binder {
	
	/**
	 * A factory for creating binders, created to simplify unit testing. 
	 * 
	 * @author shanonmcquay
	 */
	public class BinderFactory {
		public function newActionBinder(): ActionBinder {
			return new ActionBinder();
		}
		public function newTextBinder(): TextBinder {
			return new TextBinder();
		}
		public function newDateBinder(): DateBinder {
			return new DateBinder();
		}
		public function newValidationBinder(): ValidationBinder {
			return new ValidationBinder();
		}
	}
}