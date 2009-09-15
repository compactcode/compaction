package org.compaction.validation {
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	[ResourceBundle("validators")]
	[ResourceBundle("compaction")]
	
	public class ValidationMessages {
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function wasNull(): String {
			return wasRequired();
		}
		public function wasNotNull(): String {
			return _resourceManager.getString("compaction", "wasNotNull");
		}
		public function wasRequired(): String {
			return _resourceManager.getString("validators", "requiredFieldError");
		}
		public function wasLowerThanMin(): String {
			return _resourceManager.getString("validators", "lowerThanMinError");
		}
		public function wasGreaterThanMax(): String {
			return _resourceManager.getString("validators", "exceedsMaxErrorNV");
		}
		public function wasAfterToday(): String {
			return _resourceManager.getString("compaction", "wasAfterToday");
		}
	}
}