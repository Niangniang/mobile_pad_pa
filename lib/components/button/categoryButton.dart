import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

import '../../utils/tools.dart';

class CategoryButton extends StatelessWidget {
  final String intitule;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.intitule,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 6, right: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? GlobalColors.nextonbording
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(32),
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
                  child:  SizedBox(
                    height: MediaQuery.of(context).size.height * (55/MediaQuery.of(context).size.height),  // Hauteur de l'image
                    width: MediaQuery.of(context).size.width * (55/MediaQuery.of(context).size.width),   // Largeur de l'image (égale à la hauteur pour un cercle)
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),  // Rayon de moitié pour rendre l'image circulaire
                      child: CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) => const CircularProgressIndicator(
                          strokeWidth: 0.5,
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Flexible(
                  child: Text(
                    capitalizeAndReplaceUnderscore(intitule),
                    style: TextStyle(
                      color: isSelected ? GlobalColors.nextonbording : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis, // Truncate text if it is too long
                    maxLines: 1, // Show only one line of text
                  ),
                ),
              ],
            )
          ),
        ));
  }
}
