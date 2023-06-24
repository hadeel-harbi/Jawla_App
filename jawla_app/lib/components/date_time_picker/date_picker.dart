import 'package:flutter/cupertino.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/constants/constants.dart';

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: DatePicker(),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime(2016, 10, 26);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  // CupertinoModalPopup function
  void showDialog(Widget child) {
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                // Display a CupertinoDatePicker in date picker mode.
                onPressed: () => showDialog(
                  CupertinoDatePicker(
                    initialDateTime: date,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: false,
                    // This shows day of week alongside day of month
                    showDayOfWeek: false,
                    // This is called when the user changes the date.
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => date = newDate);
                    },
                  ),
                ),
                // Date format
                child: Text(
                  '${date.month}-${date.day}-${date.year}',
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
