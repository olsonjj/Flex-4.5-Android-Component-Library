package com.yapiodesign.components.android.events
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class AndroidButtonEvent extends MouseEvent
	{

		public static const MOUSE_DOWN_AND_HOLD:String = "mouseDownAndHold";

		public function AndroidButtonEvent(type:String)
		{
			super(type);
		}
	}
}