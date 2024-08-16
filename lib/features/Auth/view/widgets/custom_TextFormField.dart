import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final label;

  final TextEditingController? controller;
  final TextInputType? KeyboardTybe;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validatoruser;
  final bool? obscuretext;
  final Widget ? widget;
  CustomTextFormField({
    required this.label,
    required this.controller,
    required this.KeyboardTybe,
    required this.textInputAction,
    this.validatoruser,
    this.widget,
    this.obscuretext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext ?? false,
      validator: validatoruser,
      controller: controller,
      keyboardType: KeyboardTybe,

      textInputAction: textInputAction,
      decoration: InputDecoration(
        suffixIcon: widget,
        label: label,
        labelStyle: TextStyle(
          color: Colors.grey[800],
        ),
        fillColor: const Color.fromARGB(8, 0, 0, 0),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 143, 201, 101), width: 2.0),
        ),
      ),
      cursorColor: Colors.greenAccent,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
