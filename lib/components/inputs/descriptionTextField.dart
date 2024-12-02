import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constantes/codeColors/codeColors.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.infinity, 200)),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[^\x00-\x7F]+')),
        ],
        // focusNode: focusNode,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return '*Ce champ est obligatoire';
          }
          return null;
        },
        decoration: InputDecoration(
          //hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: GlobalColors.nextonbording,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: GlobalColors.nextonbording,
              width: 1.8,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF9FBFB),
          //labelText: hintText,
          labelStyle: const TextStyle(
            color: Color(0xFF37393c),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF37393c),
          ),
        ),
        controller: controller,
        maxLines: 10,
      ),
    );
  }
}
