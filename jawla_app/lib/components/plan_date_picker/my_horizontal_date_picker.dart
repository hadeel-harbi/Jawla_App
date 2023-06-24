library horizontal_center_date_picker;

import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/date_item.dart';
import 'package:horizontal_center_date_picker/date_item_state.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'my_date_item_widget.dart';
// import 'date_item_state.dart';
// import 'date_item_widget.dart';
// import 'datepicker_controller.dart';

// import 'date_item.dart';

class MyHorizontalDatePickerWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final String locale;
  final double width;
  final double widgetWidth;
  final double height;
  final void Function(DateTime value)? onValueSelected;
  final DatePickerController datePickerController;
  final double monthFontSize;
  final double dayFontSize;
  final double weekDayFontSize;
  final Color normalColor;
  final Color selectedColor;
  final Color disabledColor;
  final Color normalTextColor;
  final Color selectedTextColor;
  final Color disabledTextColor;
  final List<DateItem> dateItemComponentList;

  MyHorizontalDatePickerWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.widgetWidth,
    required this.datePickerController,
    this.dateItemComponentList = const <DateItem>[
      DateItem.Month,
      DateItem.Day,
      DateItem.WeekDay
    ],
    String? locale,
    this.width = 60,
    this.height = 80,
    this.onValueSelected,
    this.normalColor = Colors.white,
    this.selectedColor = Colors.black,
    this.disabledColor = Colors.white,
    this.normalTextColor = Colors.black,
    this.selectedTextColor = Colors.white,
    this.disabledTextColor = const Color(0xFFBDBDBD),
    this.monthFontSize = 12,
    this.dayFontSize = 18,
    this.weekDayFontSize = 12,
  })  : assert(dateItemComponentList.isNotEmpty,
            'dateItemComponentList  cannot be empty'),
        locale = locale ?? Intl.systemLocale;

  @override
  _MyHorizontalDatePickerWidgetState createState() => _MyHorizontalDatePickerWidgetState(datePickerController, widgetWidth,
      width, startDate, endDate, selectedDate);
}

class _MyHorizontalDatePickerWidgetState extends State<MyHorizontalDatePickerWidget> {
  int _itemCount = 0;
  double _padding = 0.0;
  final ScrollController _scrollController = ScrollController();

  _MyHorizontalDatePickerWidgetState(DatePickerController controller, double ttlWidth, double width,
      DateTime startDate, DateTime endDate, DateTime selectedDate) {
    _init(controller, ttlWidth, width, startDate, endDate, selectedDate);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(widget.locale, null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.datePickerController.scrollToSelectedItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.widgetWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _itemCount,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var dateTime = widget.datePickerController.realStartDate
                  ?.add(Duration(days: index)) ??
              widget.startDate;
          DateItemState dateItemState = _getDateTimeState(dateTime);

          return GestureDetector(
            onTap: () {
              if (dateItemState != DateItemState.DISABLED) {
                widget.datePickerController.selectedDate = dateTime;
                if (widget.onValueSelected != null) {
                  widget.onValueSelected!(dateTime);
                }
                setState(() {
                  widget.datePickerController.scrollToSelectedItem();
                });
              }
            },
            child: MyDateItemWidget(
              locale: widget.locale,
              dateTime: dateTime,
              padding: _padding,
              width: widget.width,
              height: widget.height,
              dateItemState: dateItemState,
              dayFontSize: widget.dayFontSize,
              monthFontSize: widget.monthFontSize,
              weekDayFontSize: widget.weekDayFontSize,
              normalColor: widget.normalColor,
              selectedColor: widget.selectedColor,
              disabledColor: widget.disabledColor,
              normalTextColor: widget.normalTextColor,
              selectedTextColor: widget.selectedTextColor,
              disabledTextColor: widget.disabledTextColor,
              dateItemComponentList: widget.dateItemComponentList,
            ),
          );
        },
      ),
    );
  }

  DateItemState _getDateTimeState(DateTime dateTime) {
    if (_isSelectedDate(dateTime)) {
      return DateItemState.SELECTED;
    } else {
      if (_isWithinRange(dateTime)) {
        return DateItemState.ACTIVE;
      } else {
        return DateItemState.DISABLED;
      }
    }
  }

  bool _isSelectedDate(DateTime dateTime) {
    return dateTime.year == widget.datePickerController.selectedDate?.year &&
        dateTime.month == widget.datePickerController.selectedDate?.month &&
        dateTime.day == widget.datePickerController.selectedDate?.day;
  }

  void _init(DatePickerController controller, double ttlWidth, double width,
      DateTime startDate, DateTime endDate, DateTime selectedDate) {
    int maxRowChild = 0;
    int shift = 0;
    double shiftPos;
    double widgetWidth = ttlWidth;

    maxRowChild = (widgetWidth / width).floor();

    if (maxRowChild.isOdd) {
      shift = ((maxRowChild - 1) / 2).floor();
      shiftPos = shift.toDouble();
    } else {
      shift = (maxRowChild / 2).floor();
      shiftPos = shift - 0.5;
    }

    //calc padding(L+R)
    _padding = (widgetWidth - (maxRowChild * width)) / maxRowChild;

    _itemCount = shift * 2 + endDate.difference(startDate).inDays + 1;

    controller.scrollController = _scrollController;
    controller.shift = shiftPos;
    controller.itemWidth = _padding + width;

    controller.realStartDate = startDate.subtract(Duration(days: shift));
    controller.selectedDate = selectedDate;
    controller.endDate = endDate;
    controller.startDate = startDate;
  }

  bool _isWithinRange(DateTime dateTime) {
    return widget.datePickerController.isWithinRange(dateTime);
  }
}
