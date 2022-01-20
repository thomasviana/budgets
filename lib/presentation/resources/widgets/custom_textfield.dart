import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String hintText;
  final TextInputType keyboardType;
  final Icon prefixIcon;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.onSubmit,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black45,
      autofocus: true,
      style: const TextStyle(color: Colors.black),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        hintTextDirection: TextDirection.ltr,
        prefixIcon: prefixIcon,
        fillColor: Colors.black12,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      textAlign: TextAlign.center,
      onSubmitted: (_) => onSubmit,
      keyboardType: keyboardType,
    );
  }
}
