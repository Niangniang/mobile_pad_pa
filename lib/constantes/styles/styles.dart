import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';


class AppStyles {
  static const labelStyle = TextStyle(
    color: GlobalColors.nextonbording,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
    hintStyle: const TextStyle(
      color: Color(0xFF37393c),
    ),
  );
}
