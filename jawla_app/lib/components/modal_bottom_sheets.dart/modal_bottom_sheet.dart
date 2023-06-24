import 'package:flutter/material.dart';

opensheet(BuildContext context, Widget view) {
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
          height: 600,
          child: Scaffold(backgroundColor: Colors.transparent, body: view));
    },
  );
}
