import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constantes/codeColors/codeColors.dart';

class ItemEvenementCard extends StatelessWidget {
  final image;
  final String nom;
  final String date;
  final String heure;

  const ItemEvenementCard({
    super.key,
    required this.image,
    required this.nom,
    required this.date,
    required this.heure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: GlobalColors.nextonbording.withOpacity(0.5),
          width: 2.0,
        ),
        color: const Color(0xFFF7F6FA),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -1,
            blurRadius: 5,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.65,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              child: SizedBox(
                width: 100, // Ajustez la largeur selon vos besoins
                height: 150, // Ajustez la hauteur selon vos besoins
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nom,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            heure,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
