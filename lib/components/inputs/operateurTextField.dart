import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constantes/codeColors/codeColors.dart';

class OperateurTextField extends StatelessWidget {
  const OperateurTextField(
      {super.key, required this.hintText, required this.controller});
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
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 80)),
          child: TextFormField(
            keyboardType: TextInputType.text,
            enabled: false,
            inputFormatters: [
              // FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.deny(
                  RegExp(r'[0-9]')), // Empêche les chiffres
              FilteringTextInputFormatter.deny(RegExp(
                  r'[^\x00-\x7F]+')), // Empêche les caractères non ASCII (comme les emojis)
            ],
            enableSuggestions: false,
            // autocorrect: false,
            controller: controller,
            validator: (value) => validate(value),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.primaryColor, // Couleur de la ligne bleue
                  width: 1.8, // Largeur de la ligne
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.primaryColor,
                  width: 1.8,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF9FBFB),
              labelText: hintText,
              labelStyle: const TextStyle(
                color: Color(0xFF37393c),
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
