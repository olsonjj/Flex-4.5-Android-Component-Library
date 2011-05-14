package com.yapiodesign.components.android.optionsmenu
{
	import com.yapiodesign.components.android.skins.OptionsMenuSkin;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;

	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.SkinnablePopUpContainer;
	import spark.events.IndexChangeEvent;

	[Event(name="change", type="flash.events.Event")]

	public class OptionsMenu extends SkinnablePopUpContainer
	{

		public static const OK:uint = 0x0004;
		public static const CANCEL:int = 0x0008;

		// would be awesome if skinparts could be private
		[SkinPart(required="true")]
		public var _title:Label;

		[SkinPart(required="true")]
		public var _optionsList:List;

		[SkinPart(required="true")]
		public var _okButton:Button;

		[SkinPart(required="true")]
		public var _cancelButton:Button;

		private var _flags:uint;
		private var _titleString:String;
		private var _options:ArrayCollection;

		private var _originalIndex:int;
		private var _selectedIndex:int;
		private var _selectedItem:Object;

		public function OptionsMenu()
		{
			super();
			_selectedIndex = -1;
			setStyle("skinClass", OptionsMenuSkin);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
		}

		///////////////////
		//
		//  PROTECTED
		//
		///////////////////

		protected function onButtonClicked(event:MouseEvent):void
		{

			switch (event.target)
			{
				case _cancelButton:
					_selectedIndex = _originalIndex;
					_selectedItem = _options.getItemAt(_selectedIndex);
					close(false, _selectedItem);
					break;

				default:
					close(true, selectedItem);
					break;
			}


		}


		protected function onListChanged(event:IndexChangeEvent):void
		{
			selectedIndex = event.newIndex;
			selectedItem = _optionsList.selectedItem;

			dispatchEvent(new Event(Event.CHANGE));
		}

		///////////////////
		//
		//  GETTER SETTERS
		//
		///////////////////

		public function get title():String
		{
			return _titleString;
		}

		public function set title(val:String):void
		{
			_titleString = val;
			invalidateProperties();
		}

		[Bindable]
		public function get options():ArrayCollection
		{
			return _options;
		}

		public function set options(val:ArrayCollection):void
		{
			_options = val;

			// may sure selectedIndex is within bounds of options list
			//selectedIndex = Math.max(0, Math.min(options.length - 1, selectedIndex));
			if (selectedIndex < 0)
				return;

			if (selectedIndex)
				selectedItem = options.getItemAt(selectedIndex);

			invalidateProperties();
		}

		public function get flags():uint
		{
			return _flags;
		}

		public function set flags(val:uint):void
		{
			_flags = val;
			invalidateProperties();
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			if (_selectedIndex < 0)
				_originalIndex = value;

			if (options)
			{
				// may sure selectedIndex is within bounds of options list
				_selectedIndex = Math.max(0, Math.min(options.length - 1, value));
				selectedItem = options.getItemAt(_selectedIndex);
			}
			else
			{
				_selectedIndex = value;
			}



			invalidateProperties();
		}

		public function get selectedItem():Object
		{
			return _selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
			_selectedItem = value;
		}


		///////////////////
		//
		//  OVERRIDES
		//
		///////////////////

		override protected function commitProperties():void
		{
			super.commitProperties();

			_title.text = title;
			_optionsList.dataProvider = options;
			_optionsList.selectedIndex = selectedIndex;

			switch (flags)
			{
				case 4:
					_okButton.visible = true;
					_okButton.includeInLayout = true;
					_cancelButton.visible = false;
					_cancelButton.includeInLayout = false;
					break;

				case 8:
					_okButton.visible = false;
					_okButton.includeInLayout = false;
					_cancelButton.visible = true;
					_cancelButton.includeInLayout = true;
					break;

				case 12:
					_okButton.visible = true;
					_okButton.includeInLayout = true;
					_cancelButton.visible = true;
					_cancelButton.includeInLayout = true;
					break;

				default:
					_okButton.visible = true;
					_okButton.includeInLayout = true;
					_cancelButton.visible = false;
					_cancelButton.includeInLayout = false;
					break;
			}

		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);

			if (instance == _optionsList)
			{
				_optionsList.itemRenderer = new ClassFactory(OptionsMenuItemRenderer);
				_optionsList.addEventListener(IndexChangeEvent.CHANGE, onListChanged);
			}

			if (instance == _okButton)
			{
				_okButton.addEventListener(MouseEvent.CLICK, onButtonClicked);
			}

			if (instance == _cancelButton)
			{
				_cancelButton.addEventListener(MouseEvent.CLICK, onButtonClicked);
			}

		}


		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);

			if (instance == _optionsList)
			{
				_optionsList.removeEventListener(IndexChangeEvent.CHANGE, onListChanged);
			}

			if (instance == _okButton)
			{
				_okButton.removeEventListener(MouseEvent.CLICK, onButtonClicked);
			}

			if (instance == _cancelButton)
			{
				_cancelButton.removeEventListener(MouseEvent.CLICK, onButtonClicked);
			}
		}


	}
}