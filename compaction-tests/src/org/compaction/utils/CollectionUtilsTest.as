package org.compaction.utils {
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayCollection;
	
	public class CollectionUtilsTest extends TestCase {
		public function testMapReturnsCollectionTransformedUsingTransformer(): void {
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			var result:ArrayCollection = CollectionUtils.map(source, function(item:String): String {
				return item + "foo";
			});
			assertEquals(3, result.length);
			assertEquals(true, result.contains("shanonfoo"));
			assertEquals(true, result.contains("timfoo"));
			assertEquals(true, result.contains("jackfoo"));
		}
		public function testMapIfNotNullReturnsCollectionTransformedUsingTransformerExcludingNulls(): void {
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			var result:ArrayCollection = CollectionUtils.mapIfResultNotNull(source, function(item:String): String {
				if(item == "jack") {
					return null;
				}
				return item + "foo";
			});
			assertEquals(2, result.length);
			assertEquals(true, result.contains("shanonfoo"));
			assertEquals(true, result.contains("timfoo"));
		}
		public function testFilterReturnsCollectionFoundUsingMatcher(): void{
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			var result:ArrayCollection = CollectionUtils.filter(source, function(item:String): Boolean {
				return item.search("a") != -1
			});
			assertEquals(2, result.length);
			assertEquals(true, result.contains("shanon"));
			assertEquals(true, result.contains("jack"));
		}
		public function testContainsVerifiesGivenCollectionContainsTheGivenNumberOfMatches(): void {
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			var result:Boolean = CollectionUtils.contains(1, source, function(item:String): Boolean {
				return item == "shanon";
			});
			assertEquals(true, result);
		}
		public function testRemoveRemovesAllElementsFoundUsingMatcher(): void {
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			CollectionUtils.removeAll(source, function(item:String): Boolean {
				return item == "shanon";
			});
			assertEquals(2, source.length);
			assertEquals(true, source.contains("tim"));
			assertEquals(true, source.contains("jack"));
		}
		public function testJoinConcatenatesStringsUsingDelimiter(): void {
			var source:ArrayCollection = new ArrayCollection(["shanon", "tim", "jack"]);
			var result:String = CollectionUtils.join(source, ",");
			assertEquals("shanon,tim,jack", result);
		}
	}
}