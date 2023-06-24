import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../components/cards/added_activity_card.dart';
import '../../components/plan_date_picker/plan_date_picker.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';
import '../../models/activity_model.dart';
import '../../services/api/user/reservation/reservations_by_date_response.dart';
import 'package:intl/intl.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  List allActivitiesData = [];
  List<Activity> activitiesList = [];

  final box = GetStorage();
  String date = '';
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    print("now - $now");
    String month = DateFormat('MM').format(now);
    String day = DateFormat('dd').format(now);
    date = "${now.year}-$month-$day";
    print(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          height48,

          // ------- Date Picker
          PlanDatePicker(
            myDateFunc: (datepicker) {
              final dataString = datepicker.toString().substring(0, 10);
              print(dataString);
              date = dataString;

              setState(() {});
            },
          ),

          height24,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // My Trip Plan
                const Text("My Trip Plan", style: headLineStyle1),
                height16,

                // Added Activity Cards
                futureBuilderActivitiesColumn()
              ],
            ),
          ),
        ],
      ),
    );
  }

  futureBuilderActivitiesColumn() {
    return FutureBuilder(
      future: displayReservationsByDateResponse(date),
      builder: (context, snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // showDialogFunc(context);
            return const Center(
                child: CircularProgressIndicator(
              color: secondaryColor,
            ));
          }
          if (snapshot.hasData) {
            var response = snapshot.data!;
            //------ response success
            if (response.statusCode == 200) {
              allActivitiesData = (json.decode(response.body))["data"];
              activitiesList.clear();
              for (var element in allActivitiesData) {
                activitiesList.add(Activity.fromJson(element));
              }
              print(response.body);

              return activitiesColumn();
            } else {
              //------ response error
              print(response.body);
            }
          }
          return const SizedBox(
              height: 220,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ));
        } catch (error) {
          print(error);
          return const SizedBox(
              height: 220,
              width: 200,
              child: Text(
                "Error",
                style: TextStyle(color: primaryColor),
              ));
        }
      },
    );
  }

  Widget activitiesColumn() {
    return Column(
      children: [
        for (var i = 0; i < activitiesList.length; i++)
          AddedActivityCard(
            activity: activitiesList[i],
            isLast: i == activitiesList.length - 1,
          )
      ],
    );
  }
}
