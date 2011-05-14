package com.yapiodesign.components.android.datepicker
{
	import com.flexoop.utilities.dateutils.DateUtils;
	import com.yapiodesign.components.android.skins.DatePickerPopUpSkin;
	import com.yapiodesign.components.android.stepper.VerticalStepper;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;

	import spark.components.Button;
	import spark.components.SkinnablePopUpContainer;
	import spark.events.IndexChangeEvent;

	public class DatePickerPopUp extends SkinnablePopUpContainer
	{

		[SkinPart(required="true")]
		public var _monthStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _dayStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _yearStepper:VerticalStepper;

		[SkinPart(required="true")]
		public var _okButton:Button;

		[SkinPart(required="true")]
		public var _cancelButton:Button;

		private var _date:Date;
		private var _todaysYearIndex:int;

		private var _monthsArray:Array;
		private var _yearsArray:Array;
		private var _daysArray:Array;

		public function DatePickerPopUp()
		{
			super();

			date = new Date();

			setStyle("skinClass", DatePickerPopUpSkin);

			_monthsArray = [{label: "Jan"}, {label: "Feb"}, {label: "Mar"}, {label: "Apr"}, {label: "May"}, {label: "Jun"}, {label: "Jul"}, {label: "Aug"}, {label: "Sep"}, {label: "Oct"}, {label: "Nov"}, {label: "Dec"}];

			_yearsArray = [];
			var startingYear:int = 1970
			var tempYear:int;

			for (var i:int = 0; i <= 50; i++)
			{
				tempYear = i + startingYear;
				_yearsArray.push({label: tempYear.toString()});
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
					var newDate:Date = new Date( parseInt(_yearStepper.toString()), _monthStepper.index, _dayStepper.index+1);
					this.close(true, newDate);
					break;
				case _cancelButton:
					this.close(false, null);
					break;
			}

		}


		protected function onMonthChange(event:IndexChangeEvent):void
		{
			updateDaysArray(event.newIndex);
			invalidateProperties();
		}

		protected function updateDaysArray(month:int):void
		{
			var thisMonth:Date = new Date(date.getFullYear(), month);
			var daysInMonth:int = DateUtils.daysInMonth(thisMonth);

			_daysArray = [];
			for (var i:int = 1; i <= daysInMonth; i++)
			{
				_daysArray.push({label: i.toString()});
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

			_dayStepper.data = new ArrayCollection(_daysArray);

			var maxLen:int = _daysArray.length - 1;

			if (_dayStepper.index >= maxLen)
				_dayStepper.index = maxLen;

		}

		override protected function partAdded(partName:String, instance:Object):void
		{

			super.partAdded(partName, instance);

			if (instance == _monthStepper)
			{
				_monthStepper.data = new ArrayCollection(_monthsArray);
				_monthStepper.addEventListener(IndexChangeEvent.CHANGE, onMonthChange);
				_monthStepper.index = _date.getMonth();
			}
			if (instance == _dayStepper)
			{
				updateDaysArray(_date.getMonth());
				_dayStepper.data = new ArrayCollection(_daysArray);
				_dayStepper.index = _date.getDate() - 1;
			}

			if (instance == _yearStepper)
			{
				_yearStepper.data = new ArrayCollection(_yearsArray);
				var len:int = _yearsArray.length;
				for (var i:int = 0; i < len; i++)
				{
					if (_yearsArray[i].label == date.fullYear.toString())
					{
						_yearStepper.index = i;
					}
				}

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
			if (instance == _monthStepper)
			{
				_monthStepper.removeEventListener(IndexChangeEvent.CHANGE, onMonthChange);
			}
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