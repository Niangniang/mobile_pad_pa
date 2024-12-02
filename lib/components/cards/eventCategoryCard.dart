import 'package:flutter/material.dart';
import '../../constantes/codeColors/codeColors.dart';

class CategoryEventCard extends StatelessWidget {
  final String nom;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryEventCard(
      {super.key,
      required this.nom,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        isSelected ? GlobalColors.nextonbording : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: GlobalColors.nextonbording,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: onTap,
                  child: Text(
                    nom,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: isSelected
                          ? Colors.white
                          : GlobalColors.nextonbording,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
