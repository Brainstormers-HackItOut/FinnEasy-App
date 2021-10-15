import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLength;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.enabled,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLength,
    this.hintText,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return TextFormField(
        controller: controller,
        enabled: enabled,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        autocorrect: autocorrect,
        obscureText: obscureText,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          fillColor: Theme.of(context).secondaryHeaderColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: screenWidth * 0.05),
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: screenWidth * 0.05),
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
        )
    );
  }
}