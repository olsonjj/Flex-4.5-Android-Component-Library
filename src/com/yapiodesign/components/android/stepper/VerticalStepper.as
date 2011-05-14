package com.yapiodesign.components.android.stepper
{
	import com.yapiodesign.components.android.button.AndroidButton;
	import com.yapiodesign.components.android.events.AndroidButtonEvent;
	import com.yapiodesign.components.android.skins.VerticalStepperSkin;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;

	[Event(name="change", type="spark.events.IndexChangeEvent")]

	public class VerticalStepper extends SkinnableComponent
	{

		[SkinPart(required="true")]
		public var _upButton:AndroidButton;

		[SkinPart(required="true")]
		public var _downButton:AndroidButton;

		[SkinPart(required="true")]
		public var _label:Label;

		private var _value:int;

		private var _data:ArrayCollection;

		private var _index:uint;


		public function VerticalStepper()
		{
			super();
			setStyle("skinClass", VerticalStepperSkin);
		}



		public override function set enabled(value:Boolean):void
		{
			//TODO Auto-generated method stub
			super.enabled = value;
			invalidateProperties();

		}

		public function get value():int
		{
			return _value;
		}
		
		override public function toString():String
		{
			return data.getItemAt(index).label;
		}


		public function get data():ArrayCollection
		{
			return _data;
		}

		public function set data(val:ArrayCollection):void
		{
			
			// loop through and make sure data is set
			var acLength:int = val.length;
			for (var i:int = 0; i < acLength; i++)
			{
				if (!val[i].data)
					val[i].data = i;
			}
			
			_data = val;
			invalidateProperties();
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(val:int):void
		{
			_index = val;
			invalidateProperties();
		}

		protected function onButtonClick(event:MouseEvent):void
		{

			if (!data)
				return;

			var newIndex:int;

			switch (event.target)
			{
				case _upButton:
					newIndex = index + 1;
					break;
				case _downButton:
					newIndex = index - 1;
					break;
			}

			if (newIndex < 0)
				newIndex = data.length - 1;
			else if (newIndex > data.length - 1)
				newIndex = 0;

			index = newIndex;


		}


		override protected function commitProperties():void
		{
			super.invalidateProperties();

			if (data)
				_label.text = data.getItemAt(index).label;
			else
				return;
			
			
			_value = data.getItemAt(index).data;
			
			alpha = (enabled) ? 1 : .25;

			dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE, false, true, index, index));
		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			if (instance == _upButton)
			{
				_upButton.addEventListener(MouseEvent.CLICK, onButtonClick);
				_upButton.addEventListener(AndroidButtonEvent.MOUSE_DOWN_AND_HOLD, onButtonClick);
			}
			if (instance == _downButton)
			{
				_downButton.addEventListener(MouseEvent.CLICK, onButtonClick);
				_downButton.addEventListener(AndroidButtonEvent.MOUSE_DOWN_AND_HOLD, onButtonClick);
			}
		}



		override protected function partRemoved(partName:String, instance:Object):void
		{
			if (instance == _upButton)
			{
				_upButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
				_upButton.removeEventListener(AndroidButtonEvent.MOUSE_DOWN_AND_HOLD, onButtonClick);
			}
			if (instance == _downButton)
			{
				_downButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
				_downButton.removeEventListener(AndroidButtonEvent.MOUSE_DOWN_AND_HOLD, onButtonClick);
			}
		}
	}
}