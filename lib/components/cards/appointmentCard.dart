import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import '../../constantes/textStyles/textStyle.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final String creneauDebut;
  final String creneauFin;
  final String status;
  final String objetRDV;
  final image;
  final String withWhom;
  final String nomPoste;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.description,
    required this.date,
    required this.creneauDebut,
    required this.creneauFin,
    required this.status,
    required this.objetRDV,
    required this.image,
    required this.withWhom,
    required this.nomPoste,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenez la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
      width: MediaQuery.of(context).size.width * 0.743,
      height: screenHeight * 0.1,
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(description, style: TypoStyle.textLabelStyleS14W600CBlack),
              Card(
                color: Colors.green[400],
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Text(
                    status,
                    style: TypoStyle.textLabelStyleS12W600CBlack,
                  ),
                ),
              ),
            ],
          ),
          Text(
            objetRDV,
            style: TypoStyle.textLabelStyleS12W400CBlackItalic,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 12,
                color: Colors.black,
              ),
              Text(
                date,
                style: TypoStyle.textLabelStyleS12W400CBlack,
              ),
              Text(
                "|",
                style: TypoStyle.textLabelStyleS12W400CBlack,
              ),
              const Icon(
                Icons.watch_later_outlined,
                size: 12,
                color: Colors.black,
              ),
              Text(
                "$creneauDebut -",
                style: TypoStyle.textLabelStyleS12W400CBlack,
              ),
              Text(
                creneauFin,
                style: TypoStyle.textLabelStyleS12W400CBlack,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                            strokeWidth: 0.5,
                          ),
                      errorWidget: (context, url, error) => const SizedBox(),
                      fit: BoxFit.cover,
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Column(
                children: [
                  Text(
                    withWhom,
                    style: TypoStyle.textLabelStyleS10W600CBlack,
                  ),
                  Text(
                    nomPoste,
                    style: TypoStyle.textLabelStyleS10W400CBlack,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
