import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constantes/textStyles/textStyle.dart';

class NineaTextField extends StatelessWidget {
  const NineaTextField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
  });
  final String? label;
  final String hintText;
  final TextEditingController controller;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est obligatoire';
    }
    if (value.length < 2) {
      return 'Ce champs doit contenir au moins 2 caractères';
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
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1.0),
          child: Text(
            label!,
            style: TypoStyle.textLabelStyleS16W500CPrimary,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 70)),
          child: TextFormField(
            keyboardType: TextInputType.name,
            maxLength: 28,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(
                  r"[a-zA-Z\s.,'-áéíóúÁÉÍÓÚñÑüÜ]+")), // Empêche les chiffres
              // FilteringTextInputFormatter.deny(RegExp(
              //     r'[^\x00-\x7F]+')
              // ), // Empêche les caractères non ASCII (comme les emojis)
            ],
            enableSuggestions: false,
            // autocorrect: false,
            controller: controller,
            validator: (value) => validate(value),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
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
