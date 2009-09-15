package org.compaction.action {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import org.compaction.condition.ICondition;
	import org.compaction.condition.NotCondition;
	import org.compaction.utils.CollectionUtils;
	
	[ResourceBundle("compaction")]
	
	/**
	 * Some common code required by all actions. 
	 * 
	 * @author shanonmcquay
	 */
	public class AbstractAction extends EventDispatcher implements IAction {
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		[ArrayElementType("com.compactcode.condition.ICondition")]
		private var _conditions:ArrayCollection = new ArrayCollection();
		
		[Bindable(event="actionAvailableChanged")]
		public function get available(): Boolean {
			var allTrue:Boolean = true;
			for each(var item:ICondition in _conditions) {
			 	allTrue = allTrue && item.currentValue;
			}
			return allTrue;
		}
		[Bindable(event="actionMessagesChanged")]
		public function get messages(): ListCollectionView {
			return CollectionUtils.mapIfResultNotNull(_conditions, function(item:ICondition): String {
				if(!item.currentValue) {
					return item.currentMessage;
				}
				return null;
			});
		}
		[Bindable(event="actionMessagesAsTooltipChanged")]
		public function get messagesAsTooltip(): String {
			return CollectionUtils.join(messages, "\n");
		}
		public function availableWhenTrue(condition:ICondition): void {
			_conditions.addItem(condition);
			ChangeWatcher.watch(condition, "currentValue", dispatchAvailableChangeEvent); 
			ChangeWatcher.watch(condition, "currentMessage", dispatchMessagesAndTooltipChangeEvent); 
		}
		public function availableWhenFalse(condition:ICondition): void {
			availableWhenTrue(new NotCondition(condition));
		}
		public function assertAvailable(): void {
			if(!available) {
				throw new Error(_resourceManager.getString("compaction", "actionUnavailable"));
			}
		}
		private function dispatchAvailableChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("actionAvailableChanged"));
		}
		private function dispatchMessagesAndTooltipChangeEvent(ignored:Object): void {
			dispatchEvent(new Event("actionMessagesChanged"));
			dispatchEvent(new Event("actionMessagesAsTooltipChanged"));
		}
	}
}