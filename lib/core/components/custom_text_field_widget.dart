import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color fillColor;
  final Color? labelColor;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.suffixIcon,
    this.prefixIcon,
    required this.fillColor,
    this.labelColor,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: labelColor ?? AppColors.black,
            ),
          ),
          const SpaceHeight(10.0),
        ],
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            hintText: label,
          ),
        ),
      ],
    );
  }
}
