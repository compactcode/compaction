package org.compaction.utils {
	/**
	 * To be used as an alternative to an associative array (map) when keys are not unique.
	 *   
	 * @author shanonmcquay
	 */
	public class KeyValue {
		private var _key:String
		private var _value:*;
		public function KeyValue(key:String, value:*) {
			_key = key;
			_value = value;	
		}
		public function get key(): String {
			return _key;
		}
		public function get value(): * {
			return _value;
		}
	}
}