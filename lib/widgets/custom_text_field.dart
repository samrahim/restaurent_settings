import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool? obscureText;
  final bool? enabled;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
