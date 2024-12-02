import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

class ItemAnnonceCard extends StatelessWidget {
  //final String image;
  final String titre;
  final DateTime date;
  final String lieu;

  const ItemAnnonceCard({
    super.key,
    //required this.image,
    required this.titre,
    required this.date,
    required this.lieu,
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
      width: MediaQuery.of(context).size.width * 0.6,
      //height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat("yyyy-MM-dd hh:mm").format(date),
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
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        lieu,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          /*ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const CircularProgressIndicator(), // Indicateur de chargement
              errorWidget: (context, url, error) => const SizedBox(), // Affiche un widget vide en cas d'erreur
              fit: BoxFit.cover,
              width: 100,
              height: 150,
             // fit: BoxFit.fitHeight,
            ),
          ),*/
        ],
      ),
    );
  }
}
