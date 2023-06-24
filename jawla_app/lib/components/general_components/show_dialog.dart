import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

showDialogFunc(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: const Color.fromARGB(0, 0, 0, 0),
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        color: secondaryColor,
      ),
    ),
  );
}
