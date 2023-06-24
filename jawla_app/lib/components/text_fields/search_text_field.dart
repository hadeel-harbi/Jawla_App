import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.hint,
      required this.controller,
      required this.searchOnSubmitted});

  final Function(String text) searchOnSubmitted;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String hint;
  final TextEditingController controller;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
      controller: widget.controller,
      onSubmitted: widget.searchOnSubmitted,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 234, 234, 234),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: tertiaryColor),
        prefixIcon: Icon(widget.prefixIcon, color: tertiaryColor),
      ),
    );
  }
}
