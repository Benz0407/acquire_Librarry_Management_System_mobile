import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool readOnly; 
  final initialValue; 

  const CustomTextField(
      {super.key,
      this.controller,
      required this.labelText,
      this.validator,
      this.isPassword = false,
      this.readOnly = false,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isPassword,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
        labelText: labelText, 
        border: const OutlineInputBorder(),
      ),
      readOnly: readOnly,
      initialValue: initialValue,
      );
  }
}
