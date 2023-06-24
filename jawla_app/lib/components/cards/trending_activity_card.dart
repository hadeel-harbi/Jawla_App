import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:jawla_app/models/activity_model.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';

// ignore: must_be_immutable
class TrendingActivityCard extends StatelessWidget {
  const TrendingActivityCard({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 164,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _CardImage(activity: activity),
          height8,

          // Activity Details
          SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.activityName ?? "", style: headLineStyle3),
                height8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_sharp,
                            color: primaryColor, size: 11),
                        width4,
                        Text(activity.activityCity ?? "",
                            style: headLineStyle5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Thumbnail Widget
        SizedBox(
          height: 135,
          width: 144,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
                activity.activityPic ??
                    "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                fit: BoxFit.cover),
          ),
        ),

        // Price Widget
        Positioned(
          right: 10,
          bottom: 10,
          child: BlurryContainer(
            blur: 12,
            height: 24,
            width: 51,
            elevation: 0,
            color: Colors.white30,
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Center(
              child: Text(
                activity.activityPrice != "FREE"
                    ? '${activity.activityPrice} SR'
                    : "FREE",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
