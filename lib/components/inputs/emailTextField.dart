import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

import '../../constantes/textStyles/textStyle.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;

  String? validateEmail(String value) {
    // Utilisez une expression régulière pour vérifier si c'est une adresse email valide.
    // Cette expression régulière vérifie une adresse email simple.
    // Vous pouvez ajuster l'expression régulière en fonction de vos besoins.
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value.isEmpty) {
      return null; // Le champ est vide, pas de validation nécessaire.
    } else if (!emailRegex.hasMatch(value)) {
      return "Veuillez renseigner une adresse email valide";
    }
    return null; // L'adresse email est valide.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2.0),
          child: Text(
            label,
            style: TypoStyle.textLabelStyleS16W500CPrimary,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 70)),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: false,
            controller: controller,
            validator: (value) => validateEmail(value!),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mail_outline,
                    color: GlobalColors.nextonbording,
                  )),
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
