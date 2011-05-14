package com.yapiodesign.components.android.optionsmenu
{
	import flash.display.Shape;
	import flash.display.Sprite;

	import spark.components.LabelItemRenderer;


	/**
	 *
	 * ASDoc comments for this item renderer class
	 *
	 */
	public class OptionsMenuItemRenderer extends LabelItemRenderer
	{

		private var outerCircle:Shape;
		private var selectedCircle:Shape;

		public function OptionsMenuItemRenderer()
		{
			//TODO: implement function
			super();

			this.minHeight = 72;

			this.setStyle("selectionColor", 0xFFFFFF);
			this.setStyle("downColor", 0xE11E26);

			outerCircle = new Shape();
			outerCircle.graphics.beginFill(0x666666);
			outerCircle.graphics.drawEllipse(0, 0, 48, 48);
			outerCircle.graphics.endFill();
			addChild(outerCircle);
		}


		/**
		 * @private
		 *
		 * Override this setter to respond to data changes
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			// the data has changed.  push these changes down in to the 
			// subcomponents here    

			updateSelectedView();

		}

		protected function updateSelectedView():void
		{

			if (selectedCircle)
				selectedCircle.graphics.clear();


			if (this.selected)
			{

				selectedCircle = new Shape();
				selectedCircle.graphics.beginFill(0x15DC23); //#15DC23
				selectedCircle.graphics.drawEllipse(0, 0, 22, 22);
				selectedCircle.graphics.endFill();
				addChild(selectedCircle);
			}
			else
			{
				selectedCircle = new Shape();
				selectedCircle.graphics.beginFill(0xB7B7B7); //#15DC23
				selectedCircle.graphics.drawEllipse(0, 0, 22, 22);
				selectedCircle.graphics.endFill();
				addChild(selectedCircle);
			}

			invalidateDisplayList();
		}

		public override function get selected():Boolean
		{
			//TODO Auto-generated method stub
			return super.selected;
		}

		public override function set selected(value:Boolean):void
		{
			//TODO Auto-generated method stub
			super.selected = value;
			updateSelectedView();
		}

		/**
		 * @private
		 *
		 * Override this method to create children for your item renderer
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			// create any additional children for your item renderer here

		}

		/**
		 * @private
		 *
		 * Override this method to change how the item renderer
		 * sizes itself. For performance reasons, do not call
		 * super.measure() unless you need to.
		 */
		override protected function measure():void
		{
			super.measure();
			// measure all the subcomponents here and set measuredWidth, measuredHeight, 
			// minMeasuredWidth, and minMeasuredHeight      		
		}

		/**
		 * @private
		 *
		 * Override this method to change how the background is drawn for
		 * item renderer.  For performance reasons, do not call
		 * super.drawBackground() if you do not need to.
		 */
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			// do any drawing for the background of the item renderer here     


			// THIS IS DONE UNTIL STYLES ARE SUPPORTED FOR THESE SEPARATION LINES
			this.graphics.clear();
			graphics.lineStyle(1, 0x9F9F9F);
			graphics.moveTo(0, unscaledHeight);
			graphics.lineTo(unscaledWidth, unscaledHeight);
		}

		/**
		 * @private
		 *
		 * Override this method to change how the background is drawn for this
		 * item renderer. For performance reasons, do not call
		 * super.layoutContents() if you do not need to.
		 */
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);

			// layout all the subcomponents here      
			outerCircle.y = unscaledHeight / 2 - outerCircle.height / 2;
			outerCircle.x = unscaledWidth - outerCircle.width - 15;

			selectedCircle.y = unscaledHeight / 2 - selectedCircle.height / 2;
			selectedCircle.x = outerCircle.x + 13;
		}

	}
}