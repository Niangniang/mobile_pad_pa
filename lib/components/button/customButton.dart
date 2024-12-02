import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

import '../../constantes/textStyles/textStyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.btnSize,
      this.isLoad,
      required this.colorbtn});
  final String text;
  final VoidCallback onTap;
  final Size btnSize;
  final bool? isLoad;
  final Color colorbtn;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalColors.nextonbording,
        minimumSize: Size(btnSize.width, btnSize.height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
              color: GlobalColors.nextonbording,
              width: 2.0), // Définir la couleur et l'épaisseur de la bordure
        ),
      ),
      child: Text(
        text,
        style: TypoStyle.textLabelStyleS16W600CWhite,
      ),
    );
  }
}
