package org.compaction.binder {
	import mx.collections.ICollectionView;
	import mx.controls.ComboBox;
	
	import org.compaction.utils.CollectionUtils;

	/**
	 * Creates a two way binding between an object property and a ComboBox.
	 * 
	 * Selects the combo using the first matching evaluation:
	 * 
	 * <ol>
	 * <li>dataProvider.item == object.property</li>
	 * <li>dataProvider.item.id == object.property.id</li>
	 * </ol>
	 * 
	 * @author shanonmcquay
	 */	
	public class ComboBinder extends AbstractInputBinder {
		private var _compareProperty:String = "id";
		public function set target(target:ComboBox): void {
			setTarget(target);
		}
		override protected function get targetPropertyName(): String {
			return "selectedItem";
		}
		override protected function changeListener(newValue:Object): void {
			var selectables:ICollectionView = ComboBox(_target).dataProvider as ICollectionView;
			_target[targetPropertyName] = CollectionUtils.find(selectables, function(item:Object): Boolean {
				if(item == newValue) {
					return true;
				}
				if(item && newValue) {
					if(item.hasOwnProperty(_compareProperty) && newValue.hasOwnProperty(_compareProperty)) {
						return item.id == newValue.id;
					}
				}
				return false;
			});
		}
	}
}