import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

import '../../constantes/textStyles/textStyle.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.showPassword,
      required this.obscureText});

  final String label;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback showPassword;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          child: Text(
            label,
            style: TypoStyle.textLabelStyleS16W500CPrimary,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 50)),
          child: TextFormField(
            controller: controller,
            obscureText: !obscureText,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Ce champs est obligatoire';
              }
              if (val.length < 3) {
                return 'Ce champs doit contenir au minimum 8 caractères ';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: showPassword,
                icon: obscureText
                    ? const Icon(
                        Icons.visibility_off,
                        color: GlobalColors.nextonbording,
                      )
                    : const Icon(Icons.visibility,
                        color: GlobalColors.nextonbording),
              ),
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
