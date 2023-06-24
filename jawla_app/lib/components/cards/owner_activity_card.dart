import 'package:flutter/material.dart';
import 'package:jawla_app/models/activity_model.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';

class OwnerActivityCard extends StatelessWidget {
  const OwnerActivityCard({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: AppLayout.getSize(context).width,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Thumbnail
              SizedBox(
                height: 64,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                      activity.activityPic ??
                          "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),

              // Activity Info
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          activity.activityName ?? "",
                          style: headLineStyle3,
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Show more",
                            style: headLineStyle5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: tertiaryColor,
                            size: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
