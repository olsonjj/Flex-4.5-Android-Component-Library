package com.yapiodesign.components.android.assets
{
	import flash.display.BitmapData;

	[Embed(source="/com/yapiodesign/components/android/assets/alert_icon.png")]
	public class AlertIconBD extends BitmapData
	{
		public function AlertIconBD(width:int, height:int, transparent:Boolean = true, fillColor:uint = 4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}