package org.compaction.utils {
	import flexunit.framework.TestCase;
	
	public class StringUtilsTest extends TestCase {
		
		public function testEndsWithReturnsFalseWhenSourceIsNull(): void {
			assertFalse(StringUtils.endsWith(null, "rofl"));
		}
		public function testEndsWithReturnsFalseWhenTokenIsNull(): void {
			assertFalse(StringUtils.endsWith("wowlolrofl", null));
		}
		public function testEndsWithReturnsTrueWhenSourceEndsWithGivenToken(): void {
			assertTrue(StringUtils.endsWith("wowlolrofl", "rofl"));
		}
		public function testEndsWithReturnsTrueWhenSourceEqualsGivenToken(): void {
			assertTrue(StringUtils.endsWith("rofl", "rofl"));
		}
		public function testEndsWithReturnsFalseWhenStringEndsWithOtherToken(): void {
			assertFalse(StringUtils.endsWith("wowlolrofl", "lrof"));
		}
		public function testEndsWithReturnsFalseWhenStringEndsWithOtherTokenButContainsGivenToken(): void {
			assertFalse(StringUtils.endsWith("wowrofllol", "rofl"));
		}
		
		public function testEverythingBeforeReturnsNullIfSourceIsNull(): void {
			assertEquals(null, StringUtils.everythingBefore(null, "lol"));
		}
		public function testEverythingBeforeReturnsNullIfTokenIsNull(): void {
			assertEquals(null, StringUtils.everythingBefore("omglol", null));
		}
		public function testEverythingBeforeReturnsNullIfTokenIsNotPresent(): void {
			assertEquals(null, StringUtils.everythingBefore("omglol", "lollies"));
		}
		public function testEverythingBeforeReturnsNullIfSourceEqualsToken(): void {
			assertEquals(null, StringUtils.everythingBefore("omglol", "omglol"));
		}
		public function testEverythingBeforeReturnsEverythingBeforeTokenIfPresent(): void {
			assertEquals("omg", StringUtils.everythingBefore("omglol", "lol"));
		}
	}
}