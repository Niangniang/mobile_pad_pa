import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constantes/codeColors/codeColors.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est obligatoire';
    }
    if (value.length > 28) {
      return 'Ce champ ne peut pas contenir plus de 28 caractères.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
          child: Text(
            label,
            style: const TextStyle(
              color: GlobalColors.nextonbording,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 80)),
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 28,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              /*FilteringTextInputFormatter.deny(
                  RegExp(r'[0-9]')),*/ // Empêche les chiffres
              FilteringTextInputFormatter.deny(RegExp(
                  r'[^\x00-\x7F]+')), // Empêche les caractères non ASCII (comme les emojis)
            ],
            enableSuggestions: false,
            // autocorrect: false,
            controller: controller,
            validator: (value) => validate(value),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.8,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF9FBFB),
              labelText: hintText,
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              hintStyle: const TextStyle(
                color: Color(0xFF37393c),
              ),
            ),
            onSaved: (String? value) {
              debugPrint('Value for field saved as "$value"');
            },
          ),
        ),
      ],
    );
  }
}
