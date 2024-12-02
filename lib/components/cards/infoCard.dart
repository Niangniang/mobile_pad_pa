import 'package:flutter/material.dart';
import '../../constantes/codeColors/codeColors.dart';
import '../../models/model_infrastructure/model_infrastructure.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, required this.infra});
  final Infrastructure infra;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {




  @override
  Widget build(BuildContext context) {


    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.infra.nom,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            widget.infra.commentaire != null && widget.infra.commentaire!.isNotEmpty
                ? Text(
              '${widget.infra.commentaire}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ) : const SizedBox.shrink(), // Retourne un widget vide si le commentaire est null ou vide

            const SizedBox(height: 8),
            Text(
              "${widget.infra.capacite} places",
              style: const TextStyle(
                fontSize: 14,
                color: GlobalColors.nextonbording,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: GlobalColors.nextonbording,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  "${widget.infra.adresse}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  color: GlobalColors.nextonbording,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  '+221 33 832 12 34',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
