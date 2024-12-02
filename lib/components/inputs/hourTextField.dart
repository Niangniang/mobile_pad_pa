import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HourTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  HourTextField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-2]?[0-9]:[0-5]?[0-9]$')),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
