import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import '../../constantes/codeColors/codeColors.dart';
import '../../constantes/textStyles/textStyle.dart';

class Stade {
  final String name;
  final String image;

  Stade({required this.name, required this.image});
}

class StadeCard extends StatelessWidget {
  final Infrastructure infrastructure;

  const StadeCard({Key? key, required this.infrastructure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.grey.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(infrastructure.fileUrl!),
            radius: 30,
          ),
          const SizedBox(height: 10),
          Text(
            infrastructure.nom,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 115,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                // Passez l'objet infrastructure à l'écran d'information
                context.goNamed(
                  'informationScreen',
                  extra: infrastructure,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.nextonbording,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Voir détail',
                style: TypoStyle.textLabelStyleS14W600CWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

