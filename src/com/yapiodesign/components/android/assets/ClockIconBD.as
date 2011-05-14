package com.yapiodesign.components.android.assets
{
	import flash.display.BitmapData;

	[Embed(source="/com/yapiodesign/components/android/assets/clock_icon.png")]
	public class ClockIconBD extends BitmapData
	{
		public function ClockIconBD(width:int, height:int, transparent:Boolean = true, fillColor:uint = 4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}