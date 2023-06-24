import 'package:flutter/material.dart';
import 'package:jawla_app/constants/app_styles.dart';

import '../../constants/constants.dart';

openDoneSheet(BuildContext context, String content) {
  showModalBottomSheet(
    context: (context),
    enableDrag: true,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SizedBox(
          height: 400,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: _DoneModalSheet(
                content: content,
              )));
    },
  );
}

class _DoneModalSheet extends StatelessWidget {
  const _DoneModalSheet({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 244, 244),
          borderRadius: BorderRadius.circular(20)),
      height: 400,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height32,
              Image.asset(
                "assets/images/done_icon.png",
                height: 70,
                width: 70,
              ),
              height32,
              Text(
                content,
                textAlign: TextAlign.center,
                style: headLineStyle2,
              ),
              height48,
            ],
          ),
        ),
      ),
    );
  }
}
