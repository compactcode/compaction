package org.compaction.validation {
	
	public class ValidationRoutines {
		public function isNull(value:Object): Boolean {
			return value == null;
		}
		public function isNotNull(value:Object): Boolean {
			return !isNull(value);
		}
		public function empty(value:String): Boolean {
			return isNull(value) || value == "";
		}
		public function notEmpty(value:String): Boolean {
			return !empty(value);
		}
		public function lessThan(limit:int, value:int): Boolean {
			return value < limit;
		}
		public function greaterThan(limit:int, value:int): Boolean {
			return value > limit;
		}
		public function greaterThanEqualTo(limit:int, value:int): Boolean {
			if(value == limit) {
				return true;
			}
			return greaterThan(limit, value);
		} 
		public function lessThanEqualTo(limit:int, value:int): Boolean {
			if(value == limit) {
				return true;
			}
			return lessThan(limit, value);
		}
		public function afterToday(value:Date): Boolean {
			if(!value) {
				return false;
			}
			var today:Date = new Date();
			var valueIsToday:Boolean = true;
			valueIsToday = valueIsToday && value.fullYear == today.fullYear;
			valueIsToday = valueIsToday && value.month == today.month;
			valueIsToday = valueIsToday && value.date == today.date;
			if(valueIsToday) {
				return false;
			}
			return value.getTime() > today.getTime();
		}
	}
}