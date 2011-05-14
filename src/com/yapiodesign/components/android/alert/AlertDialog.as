package com.yapiodesign.components.android.alert
{
	import com.yapiodesign.components.android.skins.AlertDialogSkin;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.states.OverrideBase;
	import mx.styles.CSSStyleDeclaration;

	import spark.components.Button;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.SkinnablePopUpContainer;
	import spark.primitives.BitmapImage;
	import com.yapiodesign.components.android.skins.AlertDialogSkin;

	public class AlertDialog extends SkinnablePopUpContainer
	{

		[SkinPart(required="true")]
		public var _titleLabel:Label;

		[SkinPart(required="true")]
		public var _messageLabel:Label;

		[SkinPart(required="true")]
		public var _okButton:Button;

		[SkinPart(required="true")]
		public var _cancelButton:Button;

		[SkinPart(required="true")]
		public var _icon:BitmapImage;

		private var _title:String;
		private var _message:String;
		private var _itemId:int;

		public function AlertDialog()
		{
			super();

			setStyle("skinClass", AlertDialogSkin);

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}



		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
		}


		protected function onButtonClick(event:MouseEvent):void
		{
			switch (event.target)
			{
				case _okButton:
					close(true);
					break;

				case _cancelButton:
					close(false);
					break;
			}
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

		public function get itemId():int
		{
			return _itemId;
		}

		public function set itemId(value:int):void
		{
			_itemId = value;
		}

		override protected function commitProperties():void
		{
			super.commitProperties();
			_titleLabel.text = title;
			_messageLabel.text = message;
		}


		protected override function partAdded(partName:String, instance:Object):void
		{
			//TODO Auto-generated method stub
			super.partAdded(partName, instance);

			if (instance == _okButton)
			{
				_okButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			}

			if (instance == _cancelButton)
			{
				_cancelButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			}

		}


		protected override function partRemoved(partName:String, instance:Object):void
		{
			//TODO Auto-generated method stub
			super.partRemoved(partName, instance);

			if (instance == _okButton)
			{
				_okButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			}

			if (instance == _cancelButton)
			{
				_cancelButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}


	}
}