import 'package:flutter/material.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/constants/app_styles.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/models/activity_model.dart';
import 'package:jawla_app/screens/main_screens/payment_screen.dart';

import '../../components/buttons/favorite_button.dart';

class ActivityDetailScreen extends StatefulWidget {
  const ActivityDetailScreen({super.key, required this.activity});

  final Activity activity;

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ActivityDuration> activityDuration =
        widget.activity.activityDuration!.map((element) => element).toList();

    return Scaffold(
      body: Stack(
        children: [
          // ----------- activity pic
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
                widget.activity.activityPic ??
                    "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                fit: BoxFit.cover),
          ),
          // ----------- back button
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
            ),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                )),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.33,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ----------- activity name
                        SizedBox(
                          width: 250,
                          child: Text(
                            widget.activity.activityName ?? "",
                            style: activityTitleStyle.copyWith(fontSize: 30),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        // ----------- favorite button
                        FavoriteButton(
                          iconSize: 20,
                          activity: widget.activity,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          color: tertiaryColor.withOpacity(0.2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // ----------- activity price
                          Text(widget.activity.activityPrice ?? '',
                              style: headLineStyle3.copyWith(
                                  color: primaryColor, fontSize: 22)),
                          Text("SR",
                              style:
                                  headLineStyle3.copyWith(color: primaryColor)),
                        ],
                      ),
                    ),

                    const Text("Overview", style: overviewStyle),
                    // ----------- activity description
                    Text(
                      widget.activity.activityDescription ?? '',
                      textAlign: TextAlign.left,
                      style: headLineStyle3.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 108, 108, 108),
                          height: 1.5),
                    ),
                    height24,
                    Column(
                      children: [
                        Row(
                          // ----------- activity city
                          children: [
                            const Icon(Icons.location_on_sharp,
                                color: primaryColor, size: 20),
                            width4,
                            Text(widget.activity.activityCity ?? "",
                                style: headLineStyle2),
                          ],
                        ),
                        height16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ----------- activity date
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: primaryColor, size: 20),
                                width4,
                                Text(
                                  activityDuration.first.activityDate ?? '',
                                  style: headLineStyle2,
                                ),
                              ],
                            ),
                            // ----------- activity time
                            Row(
                              children: [
                                const Icon(Icons.timer,
                                    color: primaryColor, size: 20),
                                width4,
                                Text(
                                  "${activityDuration.first.activityStartTime} - ${activityDuration.first.activityEndTime}",
                                  style: headLineStyle2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // ----------- book now button
                    height4,
                    Center(child: checkDateButton(activityDuration)),
                    height16,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // check if activiy date is not in the past
  Widget checkDateButton(List<ActivityDuration> activityDuration) {
    DateTime dateNow = DateTime.now();

    DateTime activityDate =
        DateTime.parse(activityDuration.first.activityDate ?? '');

    if (dateNow.isBefore(activityDate)) {
      return CustomButton(
        text: "Book Now",
        onPressed: () {
          context.push(
              screen: PaymentScreen(
            price: widget.activity.activityPrice ?? "0",
            activityId: widget.activity.activityId ?? 0,
          ));
        },
      );
    } else {
      return CustomButton(
        text: "Book Now",
        onPressed: () {},
        backgroundColor: tertiaryColor,
      );
    }
  }
}
