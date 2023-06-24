import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/constants/app_styles.dart';
import 'package:jawla_app/models/activity_model.dart';

import '../../services/api/user/favorite/add_favorite_response.dart';

// ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.iconSize,
    required this.activity,
  });

  final double iconSize;
  final Activity activity;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked = false;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 15,
        backgroundColor: const Color(0xFFF5F5F5),
        child: InkWell(
          onTap: () {
            isLiked = !isLiked;
            setState(() {});
            onLikeButtonTapped();
          },
          child: Icon(
            Icons.favorite,
            size: 20,
            color: isLiked
                ? primaryColor
                : const Color.fromARGB(255, 215, 215, 215),
          ),
        ));
  }

  onLikeButtonTapped() async {
    final response = await addFavoriteResponse(widget.activity.activityId ?? 0);
    print(response.body);
  }
}
