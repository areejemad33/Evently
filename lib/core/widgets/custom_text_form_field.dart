import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.isSecure = false,
    this.maxLines = 1,
      this.onChanged,
  });

  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator ;
  bool isSecure;
int maxLines;
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,

      obscureText: isSecure,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        
      ),
    );
  }
}
