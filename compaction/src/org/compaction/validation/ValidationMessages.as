package org.compaction.validation {
	import mx.formatters.DateFormatter;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	[ResourceBundle("validators")]
	[ResourceBundle("compaction")]
	
	public class ValidationMessages {
		public var dateFormatter:DateFormatter = new DateFormatter();
		 
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function wasNull(): String {
			return wasRequired();
		}
		public function wasNotNull(): String {
			return _resourceManager.getString("compaction", "wasNotNullError");
		}
		public function wasRequired(): String {
			return _resourceManager.getString("validators", "requiredFieldError");
		}
		public function wasLowerThanCharacterMin(min:int): String {
			var template:String = _resourceManager.getString("compaction", "wasLowerThanCharacterMinError");
			return StringUtil.substitute(template, min);
		}
		public function wasGreaterThanCharacterMax(max:int): String {
			var template:String = _resourceManager.getString("compaction", "wasGreaterThanCharacterMaxError");
			return StringUtil.substitute(template, max);
		}
		public function wasLowerThanMin(min:int): String {
			var template:String = _resourceManager.getString("compaction", "wasLowerThanMinError");
			return StringUtil.substitute(template, min);
		}
		public function wasGreaterThanMax(max:int): String {
			var template:String = _resourceManager.getString("compaction", "wasGreaterThanMaxError");
			return StringUtil.substitute(template, max);
		}
		public function wasAfterToday(): String {
			return _resourceManager.getString("compaction", "wasAfterTodayError");
		}
		public function wasAfter(date:Date): String {
			var template:String = _resourceManager.getString("compaction", "wasAfterError");
			return StringUtil.substitute(template, dateFormatter.format(date));
		}
		public function wasBefore(date:Date): String {
			var template:String = _resourceManager.getString("compaction", "wasBeforeError");
			return StringUtil.substitute(template, dateFormatter.format(date));
		}
		public function wasMissingAtSign(): String {
			return _resourceManager.getString("validators", "missingAtSignError");
		}
		public function wasTooManyAtSigns(): String {
			return _resourceManager.getString("validators", "tooManyAtSignsError");
		}
		public function wasMissingUserName(): String {
			return _resourceManager.getString("validators", "missingUsernameError");
		}
		public function wasMissingPeriodInDomain(): String {
			return _resourceManager.getString("validators", "missingPeriodInDomainError");
		}
		
	}
}