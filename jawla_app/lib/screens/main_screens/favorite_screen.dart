import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jawla_app/extensions/navigators.dart';

import '../../components/cards/trending_activity_card.dart';
import '../../constants/app_styles.dart';
import '../../models/activity_model.dart';
import '../../services/api/user/favorite/display_favorite_response.dart';
import '../activity_screens/activity_detail_screen.dart';
import '../auth_screens/login_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List allActivitiesData = [];
  List<Activity> activitiesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Center(
            child: Text(
              "Favorite",
              style: headLineStyle1.copyWith(color: Colors.white),
            ),
          ),
        ),
        leadingWidth: 100,
      ),
      body: SafeArea(
        child: Center(child: futureBuilderActivities()),
      ),
    );
  }

  gridViewActivities() {
    return activitiesList.isNotEmpty
        ? GridView.builder(
            primary: false,
            itemCount: activitiesList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => context.push(
                  screen: ActivityDetailScreen(
                    activity: activitiesList[index],
                  ),
                ),
                child: TrendingActivityCard(
                  activity: activitiesList[index],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 12 / 16,
            ),
          )
        : const SizedBox.shrink();
  }

  futureBuilderActivities() {
    return FutureBuilder(
      future: displayFavoriteResponse(),
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
              box.write("activitiesList", activitiesList);
              return gridViewActivities();
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
}
