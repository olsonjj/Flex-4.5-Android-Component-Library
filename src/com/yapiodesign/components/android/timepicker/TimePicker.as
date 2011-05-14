package com.yapiodesign.components.android.timepicker
{
	import com.flexoop.utilities.dateutils.DateUtils;
	import com.yapiodesign.components.android.skins.DatePickerPopUpSkin;
	import com.yapiodesign.components.android.skins.TimePickerSkin;
	import com.yapiodesign.components.android.stepper.VerticalStepper;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;

	import spark.components.Button;
	import spark.components.SkinnablePopUpContainer;
	import spark.events.IndexChangeEvent;

	public class TimePicker extends SkinnablePopUpContainer
	{

		[SkinPart(required="true")]
		public var _hoursStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _minutesStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _ampmStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _okButton:Button;

		[SkinPart(required="true")]
		public var _cancelButton:Button;

		private var _date:Date;

		private var _hoursArray:Array;
		private var _minutesArray:Array;
		private var _ampmArray:Array;

		public function TimePicker()
		{
			super();

			date = new Date();

			setStyle("skinClass", TimePickerSkin);

			_hoursArray = [];
			_minutesArray = [];

			_ampmArray = [{label: 'AM', data: 0}, {label: 'PM', data: 1}];

			var i:int;
			var hour:int;
			for (i = 0; i < 12; i++)
			{
				hour = (i == 0) ? 12 : i;
				_hoursArray.push({label: hour.toString(), data: hour});
			}

			var minutes:String;
			for (i = 0; i <= 59; i++)
			{
				minutes = i.toString();
				if (minutes.length == 1)
					minutes = "0" + minutes;

				_minutesArray.push({label: minutes, data: minutes});
			}



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

					var hours:int = _hoursStepper.value;
					var ampm:int = _ampmStepper.value;

					if (ampm == 0)
					{
						if (hours == 12)
							hours = 0;
					}
					else if (ampm == 1)
					{
						if (hours < 12)
							hours += 12;
					}
					var today:Date = new Date();
					var newDate:Date = new Date(today.getFullYear(), today.getMonth(), today.getDate(), hours, _minutesStepper.value);

					this.close(true, newDate);
					break;
				case _cancelButton:
					this.close(false, null);
					break;
			}

		}


		public function get date():Date
		{
			return _date;
		}

		public function set date(val:Date):void
		{
			_date = val;
		}


		override protected function commitProperties():void
		{

			super.commitProperties();

		}

		override protected function partAdded(partName:String, instance:Object):void
		{

			super.partAdded(partName, instance);

			var hours:int = _date.getHours();

			if (instance == _hoursStepper)
			{
				_hoursStepper.data = new ArrayCollection(_hoursArray);

				if (hours == 0)
					hours = 11;
				else if (hours > 12)
					hours = hours - 12;

				_hoursStepper.index = hours;
			}

			if (instance == _minutesStepper)
			{

				_minutesStepper.data = new ArrayCollection(_minutesArray);
				_minutesStepper.index = _date.getMinutes();
			}

			if (instance == _ampmStepper)
			{
				_ampmStepper.data = new ArrayCollection(_ampmArray);
				_ampmStepper.index = (hours < 12) ? 0 : 1;

			}


			if (instance == _okButton)
			{
				_okButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			}

			if (instance == _cancelButton)
			{
				_cancelButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}


		override protected function partRemoved(partName:String, instance:Object):void
		{
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