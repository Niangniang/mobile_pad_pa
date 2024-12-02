import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constantes/codeColors/codeColors.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller});

  final String label;
  final String hintText;
  final TextEditingController controller;

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    } else if (value.length != 9) {
      return 'Veuillez saisir exactement 9 chiffres';
    } else if (!RegExp(r'^(77|78|70|75|76)[0-9]{7}$').hasMatch(value)) {
      return 'Le numéro doit commencer par 77, 78, 70, 75 ou 76, suivi de 7 chiffres.';
    } else {
      return null;
    }
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
          constraints: BoxConstraints.tight(const Size(double.infinity, 70)),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controller,
            validator: (val) => validateMobile(val),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: GlobalColors.nextonbording,
                  )),
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
