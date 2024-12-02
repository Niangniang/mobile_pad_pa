import 'package:flutter/material.dart';

import '../../constantes/textStyles/textStyle.dart';

class ButtonOperateur extends StatelessWidget {
  const ButtonOperateur({
    super.key,
    required this.imgOp,
    required this.ontapOp,
  });
  final String imgOp;
  final VoidCallback ontapOp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapOp,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Image.asset(imgOp),
      ),
    );
  }
}
