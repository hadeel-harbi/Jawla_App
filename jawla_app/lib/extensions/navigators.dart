import 'package:flutter/material.dart';

extension Push on BuildContext {
  push({required Widget screen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  pushAndRemoveUntil({required Widget screen}) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}
