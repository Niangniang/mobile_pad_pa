import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  String? validateContact(String? value) {
    // Vérifier si le champ est vide
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }

    // Vérifier si c'est un numéro de téléphone potentiel
    if (value.length == 9) {
      if (RegExp(r'^(77|78|70|75|76)[0-9]{7}$').hasMatch(value)) {
        return null; // Numéro de téléphone valide
      } else {
        return 'Le numéro doit commencer par 77, 78, 70, 75 ou 76, suivi de 7 chiffres.';
      }
    }
    // Vérifier si c'est une adresse email
    if (RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return null; // Email valide
    }

    // Si ce n'est ni un numéro de téléphone valide ni un email
    return 'Veuillez saisir un numéro de téléphone valide ou une adresse email.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
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
          constraints: BoxConstraints.tight(const Size(double.infinity, 50)),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: controller,
            validator: validateContact,
            decoration: InputDecoration(
              /*suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.contact_mail,
                    color: GlobalColors.nextonbording,
                  )),*/
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
                color: Colors.black,
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
