import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constantes/codeColors/codeColors.dart';

class ReservationItem extends StatefulWidget {
  final String img;
  final String title;
  final String date;
  final String heure;
  final String localite;

  const ReservationItem({
    super.key,
    required this.title,
    required this.date,
    required this.heure,
    required this.localite,
    required this.img,
  });

  @override
  State<ReservationItem> createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.8),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Définir la forme comme cercle
              ),
              child: widget.img.isNotEmpty
                  ? ClipOval( // Utilisation de ClipOval pour couper l'image en cercle
                child: CachedNetworkImage(
                  imageUrl: widget.img,
                  placeholder: (context, url) => const CircularProgressIndicator(), // Indicateur de chargement
                  errorWidget: (context, url, error) => const SizedBox(), // Affiche un widget vide en cas d'erreur
                  fit: BoxFit.cover,
                ),
              )
                  : const SizedBox(), // Ne rien afficher si fileUrl est null ou vide
            ),
            const SizedBox(height: 8.0),
            Text(widget.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.localite,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // Aligne les éléments au début de la ligne
          children: [
            Flexible(
              child: Text(
                widget.date,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis, // Tronquer le texte trop long avec des points de suspension
              ),
            ),
            const SizedBox(width: 80.0), // Espacement horizontal entre les widgets
            Text(
              widget.heure,
              style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),

            ),
          ],
        ),


        ],
        ),
      ),
    );
  }
}
