import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/constants/app_styles.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/activity_screens/activity_detail_screen.dart';
import 'package:jawla_app/screens/auth_screens/login_screen.dart';
import 'package:jawla_app/screens/activity_screens/search_results_screen.dart';

import '../../components/text_fields/search_text_field.dart';
import '../../components/general_components/upgrade_to_owner.dart';
import '../../components/cards/activity_card.dart';
import '../../components/cards/trending_activity_card.dart';
import '../../components/modal_bottom_sheets.dart/modal_bottom_sheet.dart';
import '../../models/activity_model.dart';
import '../../services/api/activity/display_activity.dart';
import '../owner_screens/add_activity/add_activity_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List allActivitiesData = [];
  List<Activity> activitiesList = [];
  List<Activity> trendingActivitiesList = [];
  TextEditingController searchController = TextEditingController();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explore \nSaudi Arabia",
                      style: headLineStyle1,
                    ),
                    CustomButton(
                      text: "Add Activity",
                      onPressed: () {
                        box.read("is_owner") == false
                            ? opensheet(context, UpgradeToOwner())
                            : context.push(screen: const AddActivityScreen());
                      },
                      width: 100,
                      height: 35,
                    )
                  ],
                ),
                height16,
                // ------------------- Search text feild
                SearchTextField(
                  prefixIcon: Icons.search,
                  suffixIcon: FontAwesomeIcons.sliders,
                  hint: "Search",
                  controller: searchController,
                  searchOnSubmitted: (text) {
                    context.push(
                        screen: SearchResultScreen(
                            searchText: searchController.text));
                  },
                ),
                height16,
                // ------------------- Trending Activities
                const Row(
                  children: [
                    width8,
                    Icon(
                      FontAwesomeIcons.arrowTrendUp,
                      color: primaryColor,
                      size: 18,
                    ),
                    width8,
                    Text("Trending Activities", style: headLineStyle1),
                  ],
                ),
              ],
            ),
          ),

          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              child: futureBuilderActivities()),

          // ------------------- Activities list
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Column(
              children: [
                const Row(
                  children: [
                    width8,
                    Icon(
                      FontAwesomeIcons.list,
                      color: primaryColor,
                      size: 18,
                    ),
                    width8,
                    Text("Activities", style: headLineStyle1),
                  ],
                ),
                height8,
                futureBuilderActivitiesColumn(),
              ],
            ),
          )
        ],
      ),
    );
  }

//------------------------------ Future Builder of Activities (1)
  futureBuilderActivities() {
    return FutureBuilder(
      future: displayActivity(),
      builder: (context, snapshot) {
        try {
          if (snapshot.hasData) {
            var response = snapshot.data!;
            if (response.statusCode == 200) {
              allActivitiesData = (json.decode(response.body))["data"];
              activitiesList.clear();
              for (var element in allActivitiesData) {
                activitiesList.add(Activity.fromJson(element));
              }

              return activitiesRow();
            } else {
              print(json.decode(response.body));
            }
          }
          return const SizedBox(
              height: 220,
              width: 200,
              child: Center(
                  child: CircularProgressIndicator(
                color: secondaryColor,
              )));
        } catch (error) {
          box.remove("token");
          context.push(screen: const LoginScreen());
          return SizedBox(
              height: 220,
              width: 200,
              child: Text(
                "$error",
                style: const TextStyle(color: primaryColor),
              ));
        }
      },
    );
  }

  Widget activitiesRow() {
    trendingActivitiesList = activitiesList.getRange(3, 7).toList();
    return Row(
        children: trendingActivitiesList
            .map((element) => InkWell(
                  onTap: () => context.push(
                      screen: ActivityDetailScreen(
                    activity: element,
                  )),
                  child: TrendingActivityCard(
                    activity: element,
                  ),
                ))
            .toList());
  }

//------------------------------ Future Builder of Activities (2)
  futureBuilderActivitiesColumn() {
    return FutureBuilder(
      future: displayActivity(),
      builder: (context, snapshot) {
        try {
          if (snapshot.hasData) {
            var response = snapshot.data!;
            if (response.statusCode == 200) {
              allActivitiesData = (json.decode(response.body))["data"];
              activitiesList.clear();
              for (var element in allActivitiesData) {
                activitiesList.add(Activity.fromJson(element));
              }

              return activitiesColumn();
            } else {
              print(json.decode(response.body));
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
          box.remove("token");
          context.push(screen: const LoginScreen());
          return const SizedBox(
              height: 220,
              width: 200,
              child: Text(
                "No Connetion",
                style: TextStyle(color: primaryColor),
              ));
        }
      },
    );
  }

  Widget activitiesColumn() {
    return Column(
        children: activitiesList
            .map((element) => InkWell(
                  onTap: () => context.push(
                      screen: ActivityDetailScreen(activity: element)),
                  child: ActivityCard(
                    activity: element,
                  ),
                ))
            .toList());
  }
}
