import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

import '../../constantes/textStyles/textStyle.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
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
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 130)),
          child: TextField(
            keyboardType: TextInputType.name, // Nombre minimum de lignes
            maxLines: 8, // Nombre maximum de lignes
            enableSuggestions: false,
            // autocorrect: false,
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.2,
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
            /*onSaved: (String? value) {
              debugPrint('Value for field saved as "$value"');
            },*/
          ),
        ),
      ],
    );
  }
}
