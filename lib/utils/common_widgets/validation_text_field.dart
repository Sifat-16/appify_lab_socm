import 'package:flutter/material.dart';

class ValidationTextField extends StatelessWidget {
  ValidationTextField({super.key,
    required this.textEditingController,
    required this.validateFunction,
    required this.validate,
    required this.label
  });
  TextEditingController textEditingController;
  Function(String) validateFunction;
  bool validate;
  String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (val) {
        validateFunction(val);

      },
      decoration: InputDecoration(
        labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        enabledBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            borderRadius: BorderRadius.circular(12)),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: validate == false ? Colors.red : Colors.green,
              width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
