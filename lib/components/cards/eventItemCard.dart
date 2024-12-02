import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

class ItemEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;
  final String heureDebut;
  final String id;

  const ItemEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.heureDebut,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Card(
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.8),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.01,
            ),
            color: const Color(0xFFF7F6FA),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 5,
                offset: const Offset(-3, 0),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 5,
                offset: const Offset(3, 0),
              ),
            ], // Coins arrondis
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Affichage de l'image
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: imagePath.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imagePath,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  strokeWidth: 0.5,
                                ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const ClipOval(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/noto-v1_stadium.png'),
                          ),
                        ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  decoration: const BoxDecoration(
                    color: GlobalColors.nextonbording,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Text(
                    heureDebut,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
