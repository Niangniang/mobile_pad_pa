import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

class CategoryButtonAccueil extends StatelessWidget {
  final String intitule;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButtonAccueil({
    super.key,
    required this.intitule,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 6, right: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? GlobalColors.nextonbording : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? const Border(
                bottom: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1,
                ),
              )
                  : const Border(
                top: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 0.7,
                ),
                bottom: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 0.7,
                ),
                left: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 0.7,
                ),
                right: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 0.7,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              intitule,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ));
  }
}
