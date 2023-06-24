import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/services/api/activity/search_activity.dart';

import '../../components/cards/activity_card.dart';
import '../../constants/app_styles.dart';
import '../../models/activity_model.dart';
import 'activity_detail_screen.dart';
import '../auth_screens/login_screen.dart';

// ignore: must_be_immutable
class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key, required this.searchText});

  final String searchText;

  List allActivitiesData = [];
  List<Activity> activitiesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        title: const Text(
          "Search Result",
          style: headLineStyle1,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: futureBuilderActivitiesColumn(context)),
        ),
      ),
    );
  }

  futureBuilderActivitiesColumn(BuildContext context) {
    return FutureBuilder(
      future: searchActivityResopnse(searchText),
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

              return activitiesColumn(context);
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

  Widget activitiesColumn(BuildContext context) {
    return Column(
        children: activitiesList
            .map((element) => InkWell(
                  onTap: () {
                    context.push(
                        screen: ActivityDetailScreen(activity: element));
                  },
                  child: ActivityCard(
                    activity: element,
                  ),
                ))
            .toList());
  }
}
