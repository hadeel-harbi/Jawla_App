import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/date_item.dart';
import 'package:horizontal_center_date_picker/date_item_state.dart';
// import 'date_item_state.dart';
import 'package:intl/intl.dart';

// import 'date_item.dart';

class MyDateItemWidget extends StatelessWidget {
  ///display [DateTime]
  final DateTime dateTime;

  ///State of the date
  final DateItemState dateItemState;

  final String locale;

  ///padding of the item widget
  final double padding;

  final double width;
  final double height;

  final double? monthFontSize;
  final double? dayFontSize;
  final double? weekDayFontSize;
  final Color? normalColor;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? normalTextColor;
  final Color? selectedTextColor;
  final Color? disabledTextColor;

  final List<DateItem> dateItemComponentList;

  MyDateItemWidget({
    super.key,
    required this.dateTime,
    required this.dateItemState,
    required this.width,
    required this.height,
    required this.dateItemComponentList,
    required this.locale,
    this.padding = 0.0,
    this.normalColor,
    this.selectedColor,
    this.disabledColor,
    this.normalTextColor,
    this.selectedTextColor,
    this.disabledTextColor,
    this.monthFontSize,
    this.dayFontSize,
    this.weekDayFontSize,
  }) : assert(dateItemComponentList.isNotEmpty,
            'dateItemComponentList cannot be empty');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + padding,
      height: height,
      padding: EdgeInsets.only(left: padding / 2, right: padding / 2),
      color: _getContainerColorByState(dateItemState),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(dateItemComponentList.length, (index) {
          switch (dateItemComponentList[index]) {
            case DateItem.WeekDay:
              return Text(DateFormat.E(locale).format(dateTime),
                  style: TextStyle(
                      color: _getTextColorByState(dateItemState),
                      fontSize: weekDayFontSize,
                      fontWeight: _getTextWeightByState(dateItemState)));
            case DateItem.Day:
              return Text(
                DateFormat.d().format(dateTime),
                style: TextStyle(
                    color: _getTextColorByState(dateItemState),
                    fontSize: dayFontSize,
                    fontWeight: _getTextWeightByState(dateItemState)),
              );
            case DateItem.Month:
              return Text(
                DateFormat.MMM(locale).format(dateTime),
                style: TextStyle(
                    color: _getTextColorByState(dateItemState),
                    fontSize: monthFontSize,
                    fontWeight: _getTextWeightByState(dateItemState)),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }

  Color? _getContainerColorByState(DateItemState state) {
    switch (state) {
      case DateItemState.ACTIVE:
        return normalColor;
      case DateItemState.SELECTED:
        return selectedColor;
      default:
        return disabledColor;
    }
  }

  Color? _getTextColorByState(DateItemState state) {
    switch (state) {
      case DateItemState.ACTIVE:
        return normalTextColor;
      case DateItemState.SELECTED:
        return selectedTextColor;
      default:
        return disabledTextColor;
    }
  }

  FontWeight _getTextWeightByState(DateItemState state) {
    switch (state) {
      case DateItemState.ACTIVE:
        return FontWeight.bold;
      case DateItemState.SELECTED:
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }
}
