package org.compaction {
	[Bindable]
	public class BindableCustomer {
		public var name:String;
		public var birth:Date;
		public var spouse:BindableCustomer;
	}
}