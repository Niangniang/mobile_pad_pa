import 'package:flutter/material.dart';

class TextButtonApp extends StatelessWidget {
  const TextButtonApp({
    super.key,
    required this.text,
    required this.onTap,
    required this.txtStyle,
  });
  final String text;
  final VoidCallback onTap;
  final TextStyle txtStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: txtStyle,
        ));
  }
}
