import 'package:flutter/material.dart';

import 'color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool obscureText;

  final String label;
  final TextEditingController? controller;
  final TextInputType input;
  final bool isReadonly;
  final VoidCallback? callback;
  final int maxLines;
  final int maxLength;
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.input = TextInputType.text,
    this.controller,
    this.isReadonly = false,
    this.callback,
    this.maxLines = 1,
    this.maxLength = 500,
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadonly,
      onTap: callback,
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.white,
      obscureText: obscureText,
      keyboardType: input,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: (label.isEmpty) ? hintText : label,
        label: Text(hintText),
        labelStyle: TextStyle(color: themeColor),
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: themeColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: themeColor, width: 2),
        ),
      ),
    );
  }
}
