import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/components/modal_bottom_sheets.dart/done_modal_bottom_sheet.dart';
import 'package:jawla_app/components/snack_bar/snack_bar.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/models/activity_model.dart';
import 'package:jawla_app/screens/main_screens/my_navigation_bar.dart';
import 'package:jawla_app/screens/owner_screens/add_activity/add_activity_screen.dart';

import '../../components/general_components/show_dialog.dart';
import '../../constants/app_styles.dart';
import '../../services/api/owner/delete_activity_response.dart';
import '../../services/api/owner/reservations_number_response.dart';

class OwnerActivityDetailsScreen extends StatelessWidget {
  const OwnerActivityDetailsScreen({super.key, required this.activity});

  final Activity activity;
  @override
  Widget build(BuildContext context) {
    final List<ActivityDuration> activityDuration =
        activity.activityDuration!.map((element) => element).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
      ),
      //------------------ body
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
                activity.activityPic ??
                    "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                fit: BoxFit.cover),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .25,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                            child: Text(activity.activityName ?? '',
                                style: activityTitleStyle)),
                        height32,
                        const Row(
                          children: [
                            Text(
                              'Details',
                              style: headLineStyle1,
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.alarm,
                              size: 30,
                              color: primaryColor,
                            ),
                            width16,
                            Text(
                              "${activityDuration.first.activityStartTime ?? ''} - ${activityDuration.first.activityEndTime ?? ''}",
                              style: activityContent,
                            ),
                          ],
                        ),
                        height16,
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 30,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              activityDuration.first.activityDate ?? '',
                              style: activityContent,
                            )
                          ],
                        ),
                        height32,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Number of bookings ',
                            style: headLineStyle1,
                          ),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person_3_rounded,
                                color: primaryColor, size: 30),
                            width8,
                            //----------- person number response
                            futureBuilderActivityReservationsNumbers(context)
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "Delete",
                            onPressed: () async {
                              showDialogFunc(context);
                              //------------ delete activity response
                              final response = await deleteActivityResponse(
                                  activity.activityId ?? 0);
                              if (response.statusCode == 200) {
                                print(response.body);

                                openDoneSheet(context,
                                    "Your activity has been deleted successfully");

                                Future.delayed(const Duration(seconds: 2), () {
                                  context.push(
                                      screen: const MyNavigationBar(
                                    screenIndex: 3,
                                  ));
                                });
                              } else {
                                print(response.body);
                                snackBar(context, "Sorry, Error");
                              }
                            },
                            width: 140,
                          ),
                          CustomButton(
                            text: "Edit",
                            onPressed: () {
                              context.push(
                                screen: const AddActivityScreen(),
                              );
                            },
                            width: 140,
                            backgroundColor: secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  futureBuilderActivityReservationsNumbers(BuildContext context) {
    return FutureBuilder(
      future: reservationsNumberResponse(activity.activityId ?? 0),
      builder: (context, snapshot) {
        try {
          if (snapshot.hasData) {
            var response = snapshot.data!;
            if (response.statusCode == 200) {
              final number = (json.decode(response.body))["data"];

              return Text(
                "$number",
                style: activityContent,
              );
            } else {
              print(json.decode(response.body));
              return const Text("");
            }
          }
          return const SizedBox(
              height: 15,
              width: 15,
              child: Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ));
        } catch (error) {
          print(error);
          return const Text(
            "",
          );
        }
      },
    );
  }
}
