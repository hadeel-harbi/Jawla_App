import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/main_screens/my_navigation_bar.dart';

import '../../../components/buttons/button.dart';
import '../../../components/general_components/show_dialog.dart';
import '../../../components/modal_bottom_sheets.dart/done_modal_bottom_sheet.dart';
import '../../../components/snack_bar/snack_bar.dart';
import '../../../constants/app_styles.dart';
import '../../../constants/constants.dart';
import '../../../services/api/owner/add_activity_response.dart';

// ignore: must_be_immutable
class AddActivitySecondScreen extends StatefulWidget {
  const AddActivitySecondScreen({super.key, required this.addActivityMap});

  final Map addActivityMap;
  @override
  State<AddActivitySecondScreen> createState() =>
      _AddActivitySecondScreenState();
}

class _AddActivitySecondScreenState extends State<AddActivitySecondScreen> {
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  DateTime dateTime = DateTime.now();
  String? activityPic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Add Activity"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Date Text
              const Text("Date", style: headLineStyle2),
              height8,
              Row(
                children: [
                  // Date Picker Textfield
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.72,
                    child: TextField(
                      readOnly: true,
                      style:
                          headLineStyle2.copyWith(fontWeight: FontWeight.w500),
                      controller: dateController,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        hintText: dateController.text,
                        filled: false,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  width4,

                  // Date Picker Button
                  IconButton(
                    onPressed: () => showDialog(
                      CupertinoDatePicker(
                        initialDateTime: dateTime,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: false,
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => dateTime = newDate);
                          String month = DateFormat('MM').format(dateTime);
                          String day = DateFormat('dd').format(dateTime);
                          dateController.text = '${dateTime.year}-$month-$day';
                        },
                      ),
                    ),
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                ],
              ),
              height24,

              // Time Text
              const Text("Time", style: headLineStyle2),
              height8,

              // Time Textfields
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Start Time Textfield
                  SizedBox(
                    width: 140,
                    child: TextField(
                      readOnly: true,
                      style:
                          headLineStyle2.copyWith(fontWeight: FontWeight.w500),
                      controller: startTimeController,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        hintText: startTimeController.text,
                        suffixIcon: IconButton(
                          onPressed: () => showDialog(
                            CupertinoDatePicker(
                              initialDateTime: dateTime,
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => dateTime = newTime);
                                startTimeController.text =
                                    // '${dateTime.hour}:${dateTime.minute}';
                                    "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, "0")}";
                              },
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    "to",
                    style: headLineStyle2.copyWith(fontWeight: FontWeight.w500),
                  ),

                  // End Time Textfield
                  SizedBox(
                    width: 140,
                    child: TextField(
                      readOnly: true,
                      style:
                          headLineStyle2.copyWith(fontWeight: FontWeight.w500),
                      controller: endTimeController,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        hintText: endTimeController.text,
                        suffixIcon: IconButton(
                          onPressed: () => showDialog(
                            CupertinoDatePicker(
                              initialDateTime: dateTime,
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => dateTime = newTime);
                                endTimeController.text =
                                    "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, "0")}";
                              },
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 300),

              // Next Button
              Center(
                  child: CustomButton(
                text: "Add Activit",
                onPressed: () async {
                  showDialogFunc(context);
                  // ------------- add activity response
                  activityPic = box.read("imageUrl");
                  box.remove("imageUrl");

                  Map addActivityBody = {
                    ...widget.addActivityMap,
                    ...{
                      "activity_date": dateController.text,
                      "activity_start_time": startTimeController.text,
                      "activity_end_time": endTimeController.text,
                      "activity_pic": activityPic
                    }
                  };
                  print(addActivityBody);
                  final response =
                      await addActivityResponse(body: addActivityBody);

                  if (response.statusCode == 200) {
                    print(response.body);
                    openDoneSheet(
                        context, "Your activity has been deleted successfully");

                    Future.delayed(const Duration(seconds: 2), () {
                      context.push(
                          screen: const MyNavigationBar(
                        screenIndex: 0,
                      ));
                    });
                  } else {
                    print(response.body);
                    snackBar(context, "Sorry, try again");
                    Future.delayed(const Duration(seconds: 2), () {
                      context.push(
                          screen: const MyNavigationBar(
                        screenIndex: 0,
                      ));
                    });
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 400,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 240,
              padding: const EdgeInsets.only(top: 6),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
            Container(
              height: 130,
              padding: const EdgeInsets.only(
                  top: 5, bottom: 55, left: 30, right: 30),
              width: AppLayout.getSize(context).width,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: CustomButton(
                onPressed: Navigator.of(context).pop,
                text: "Set Time",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
