import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

Widget label(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Text(
      text,
      style: headLineStyle2,
    ),
  );
}
