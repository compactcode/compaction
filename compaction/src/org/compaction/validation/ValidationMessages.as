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
		public function mustNotPrecedeCharacterMin(min:int): String {
			var template:String = _resourceManager.getString("compaction", "mustNotPrecedeCharacterMinError");
			return StringUtil.substitute(template, min);
		}
		public function mustNotExceedCharacterMax(max:int): String {
			var template:String = _resourceManager.getString("compaction", "mustNotExceedCharacterMaxError");
			return StringUtil.substitute(template, max);
		}
		public function mustNotPrecedeMin(min:int): String {
			var template:String = _resourceManager.getString("compaction", "mustNotPrecedeMinError");
			return StringUtil.substitute(template, min);
		}
		public function mustNotExceedMax(max:int): String {
			var template:String = _resourceManager.getString("compaction", "mustNotExceedMaxError");
			return StringUtil.substitute(template, max);
		}
		public function mustBeBeforeToday(): String {
			return _resourceManager.getString("compaction", "mustBeBeforeTodayError");
		}
		public function mustBeAfter(date:Date): String {
			var template:String = _resourceManager.getString("compaction", "mustBeAfterError");
			return StringUtil.substitute(template, dateFormatter.format(date));
		}
		public function mustBeBefore(date:Date): String {
			var template:String = _resourceManager.getString("compaction", "mustBeBeforeError");
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