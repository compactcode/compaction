package org.compaction.utils {
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	/**
	 * A bunch of utility methods for dealing with flex collections.
	 * 
	 * @author shanonmcquay
	 */
	public class CollectionUtils {
		/**
		 * Creates a new collection by applying to given transform to each element in the source collection.
		 * 
		 * @param source The source collection.
		 * @param transform function(item:*): *
		 * @return A new collection of mapped/transformed elements.
		 */
		public static function map(source:ListCollectionView, transform:Function): ArrayCollection {
			var mapped:ArrayCollection = new ArrayCollection();
			for each(var item:Object in source) {
				mapped.addItem(transform(item));
			}
			return mapped;
		}
		/**
		 * As per map, except the new collection is guaranteed to contain no null objects.
		 *  
		 * @param source The source collection.
		 * @param transform function(item:*): *
		 * @return A new collection of mapped/transformed elements.
		 */
		public static function mapIfResultNotNull(source:ListCollectionView, transform:Function): ArrayCollection {
			var mapped:ArrayCollection = new ArrayCollection();
			for each(var item:Object in source) {
				var result:Object = transform(item);
				if(result) {
					mapped.addItem(result);
				}
			}
			return mapped;
		}
		/**
		 * Creates a new collection by applying the given matcher to each element in the source collection
		 * 
		 * @param source The source collection.
		 * @param matcher function(item:*): Boolean
		 * @return A new collection for elements that returned true when applied to the matcher.
		 */
		public static function filter(source:ListCollectionView, matcher:Function): ArrayCollection {
			var filtered:ArrayCollection = new ArrayCollection();
			for each(var item:Object in source) {
				if(matcher(item)) {
					filtered.addItem(item);
				}
			}
			return filtered;
		}
		/**
		 * Filters the source collection then determines if the number of results match the given number.
		 * 
		 * @param numberOfMatches The amount 
		 * @param source The source collection.
		 * @param matcher function(item:*): Boolean
		 * @return True if number results from the filter matched the given number. 
		 */
		public static function contains(numberOfMatches:int, source:ListCollectionView, matcher:Function): Boolean {
			return filter(source, matcher).length == numberOfMatches;
		}
		/**
		 * Removes all elements from the given source collection that return true for the given matcher.
		 * @param source The source collection.
		 * @param matcher function(item:*): Boolean
		 */
		public static function removeAll(source:ListCollectionView, matcher:Function): void {
			var itemsToRemove:ListCollectionView =  filter(source, matcher);
			for each(var item:Object in itemsToRemove) {
				if(source.contains(item)) {
					source.removeItemAt(source.getItemIndex(item));
				}
			}
		}
		/**
		 * Concatenates a collection of strings using the given delimeter.
		 * 
		 * @param source The source collection of String elements.
		 * @param delimiter The token used to delimit each element as they are joined.
		 * @return A string concatenation of the given collection.
		 */
		public static function join(source:ListCollectionView, delimiter:String): String {
			var joined:String = "";
			for each(var item:String in source) {
				if(joined != "") {
					joined += delimiter;
				}
				joined += item;
			}
			return joined;
		}
	}
}