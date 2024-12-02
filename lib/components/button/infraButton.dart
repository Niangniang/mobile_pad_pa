import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfraButton extends StatelessWidget {
  final String intitule;
  final String fileUrl;
  final VoidCallback onTap;

  const InfraButton({
    super.key,
    required this.intitule,
    required this.fileUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Limitation de la taille de l'image avec SizedBox
            SizedBox(
              height: MediaQuery.of(context).size.height * (55/MediaQuery.of(context).size.height),  // Hauteur de l'image
              width: MediaQuery.of(context).size.width * (55/MediaQuery.of(context).size.width),   // Largeur de l'image (égale à la hauteur pour un cercle)
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: CachedNetworkImage(
                  imageUrl: fileUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(
                    strokeWidth: 0.5,  // Valeur réduite pour une ligne plus fine
                  ),
                  errorWidget: (context, url, error) => const SizedBox(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8), // Espace entre l'image et le texte
            // Texte avec Flexible pour empêcher le débordement
            Flexible(
              child: Text(
                intitule,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF128736),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,  // Couper le texte s'il est trop long
                maxLines: 2,  // Limiter à deux lignes
                textAlign: TextAlign.center, // Centrer le texte
              ),
            ),
          ],
        ),
      ),
    );
  }



}
