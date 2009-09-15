package org.compaction.utils {
	/**
	 * A bunch of utility methods for dealing with objects.
	 * 
	 * @author shanonmcquay
	 */
	public class ObjectUtils {
		/**
		 * Sets the given value onto the host property in a null safe way.
		 * 
		 * e.g. 
		 * 
		 * class Customer {
		 *   public var name:String;
		 *   public var spouse:Customer;
		 * }
		 * 
		 * setValueToHost(new Customer(), ["spouse", "name"], "fred"); 
		 * 
		 * @param host The host of the property chain.
		 * @param propertyChain A property chain.
		 * @param value The value to set.
		 */
		public static function setValueToHost(host:Object, propertyChain:Array, value:Object): void {
			if(host && propertyChain) {
				host = getLastHost(host, propertyChain);
				if(host) {
					host[getPropertyName(propertyChain)] = value;
				}
			}
		}
		/**
		 * Gets the value from the given host property in a nul safe way.
		 * 
		 * e.g. 
		 * 
		 * class Customer {
		 *   public var name:String;
		 *   public var spouse:Customer;
		 * }
		 * 
		 * getValueFromHost(new Customer(), ["spouse", "name"]);
		 * 
		 * @param host The host of the property chain.
		 * @param propertyChain A property chain.
		 * @return The requested property or null if a null object was encountered in the property chain.
		 */
		public static function getValueFromHost(host:Object, propertyChain:Array): Object {
			if(host && propertyChain) {
				host = getLastHost(host, propertyChain);
				if(host) {
					return host[getPropertyName(propertyChain)];
				}
			}
			return null;
		}
		private static function getLastHost(host:Object, property:Array): Object {
			if(property.length > 1) {
				for (var i:int = 0; i < property.length - 1; i++) {
					if(host) {
						host = host[property[i]];
					}
				}
			}
			return host;
		}
		private static function getPropertyName(property:Array): Object {
			return property[property.length - 1];
		}
	}
}