import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField(
      {super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          hintText: hint,
          hintStyle: const TextStyle(color: tertiaryColor),
        ));
  }
}
