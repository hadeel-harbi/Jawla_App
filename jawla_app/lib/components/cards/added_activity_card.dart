import 'package:flutter/material.dart';
import 'package:jawla_app/models/activity_model.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';
import 'package:intl/intl.dart';

import '../general_components/dashed_line.dart';

class AddedActivityCard extends StatefulWidget {
  const AddedActivityCard({
    super.key,
    this.isLast = false,
    required this.activity,
  });

  final Activity activity;
  final bool? isLast;

  @override
  State<AddedActivityCard> createState() => _AddedActivityCardState();
}

DateTime now = DateTime.now();
String formattedTime = DateFormat.Hms().format(now);

class _AddedActivityCardState extends State<AddedActivityCard> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    final List<ActivityDuration> activityDuration =
        widget.activity.activityDuration!.map((element) => element).toList();
    return Stack(
      children: [
        Container(
          height: 121,
          width: AppLayout.getSize(context).width,
          padding:
              const EdgeInsets.only(top: 18, bottom: 18, left: 24, right: 52),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 11,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date and Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(activityDuration.first.activityDate ?? '',
                      // DateFormat('dd MM yyyy').format(DateTime.now())
                      style: headLineStyle7.copyWith(fontSize: 14)),
                  Text(
                      "${activityDuration.first.activityStartTime} - ${activityDuration.first.activityEndTime}",
                      style: headLineStyle7.copyWith(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  // Thumbnail
                  SizedBox(
                    height: 55,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                          widget.activity.activityPic ??
                              'https://www.touchtaiwan.com/images/default.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Activity Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.activity.activityName ?? '',
                          style: headLineStyle4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_sharp,
                              color: primaryColor, size: 12),
                          const SizedBox(width: 2),
                          Text(widget.activity.activityCity ?? '',
                              style: headLineStyle6),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Dashed Line
        widget.isLast == true
            ? const SizedBox.shrink()
            : const Align(
                heightFactor: 1.5,
                widthFactor: 105,
                alignment: Alignment.bottomRight,
                child: DashedLine(
                  height: 7,
                  width: 2,
                  lineHeight: 92,
                ),
              ),

        // Checkbox
        Align(
          heightFactor: 1.2,
          widthFactor: 10.3,
          alignment: Alignment.bottomRight,
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: isCheck,
              onChanged: (value) {
                setState(() {
                  isCheck = value!;
                });
              },
              activeColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
