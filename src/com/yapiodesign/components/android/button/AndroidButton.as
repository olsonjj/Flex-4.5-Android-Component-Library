package com.yapiodesign.components.android.button
{
	import com.yapiodesign.components.android.events.AndroidButtonEvent;
	import com.yapiodesign.components.android.skins.AndroidButtonSkin;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import spark.components.Button;

	[Event(name="mouseDownAndHold", type="com.yapiodesign.components.android.events.AndroidButtonEvent")]

	public class AndroidButton extends Button
	{

		private var _mouseDownCount:int = 0;

		public function AndroidButton()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		}

		protected function onAddedToStage(event:Event):void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		protected function onMouseDown(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			addEventListener(Event.ENTER_FRAME, onTick);

			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		protected function onTick(event:Event):void
		{
			_mouseDownCount++;
			if (_mouseDownCount % 8 == 0)
				dispatchEvent(new AndroidButtonEvent(AndroidButtonEvent.MOUSE_DOWN_AND_HOLD));
		}

		protected function onMouseUp(event:MouseEvent):void
		{
			_mouseDownCount = 0;
			removeEventListener(Event.ENTER_FRAME, onTick);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
	}
}