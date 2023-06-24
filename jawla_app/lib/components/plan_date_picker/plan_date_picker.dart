import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:jawla_app/constants/constants.dart';

import '../../constants/app_styles.dart';
import 'my_horizontal_date_picker.dart';

class PlanDatePicker extends StatefulWidget {
  const PlanDatePicker({super.key, required this.myDateFunc});

  final Function(DateTime)? myDateFunc;

  @override
  _PlanDatePickerState createState() => _PlanDatePickerState();
}

class _PlanDatePickerState extends State<PlanDatePicker> {
  final DatePickerController _datePickerController = DatePickerController();
  String dateString = '';

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 0));
    DateTime endDate = now.add(const Duration(days: 14));
    return MyHorizontalDatePickerWidget(
        startDate: startDate,
        endDate: endDate,
        selectedDate: now,
        normalColor: Colors.transparent,
        selectedColor: Colors.transparent,
        disabledColor: Colors.transparent,
        selectedTextColor: primaryColor,
        widgetWidth: AppLayout.getSize(context).width,
        datePickerController: _datePickerController,
        onValueSelected: widget.myDateFunc);
  }
}
/*
(date) {
        dateString = date.toString();
        dateString = dateString.substring(0, 10);
        print("**** $dateString");
        widget.myDateFunc(dateString);
      },
*/