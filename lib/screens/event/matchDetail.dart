import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
import '../../components/cards/matchDetailCard.dart';
import '../../constantes/codeColors/codeColors.dart';

class MatchDetailScreen extends StatefulWidget {
  final Evenement evenement;
  final String id;
  final String origin;

  const MatchDetailScreen({
    super.key,
    required this.evenement,
    required this.id,
    required this.origin,

  });

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 24,
            ),
              onPressed: () {

              debugPrint("Context name ======> ${context.toString()}");
              debugPrint("Origin name ======> ${widget.origin}");
                context.pop(); // Retirer la page actuelle
                if (widget.origin == 'evenement') {
                  context.go('/eventHomePage'); // Rediriger vers la page d'événements
                } else {
                  context.go('/accueil'); // Rediriger vers la page d'accueil
                }
              },
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Détail de l'événement",
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
            ],
          ),
        ),
        elevation: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: Stack(
                children: [
                  Positioned(

                    child: CachedNetworkImage(imageUrl: widget.evenement.creneau!.infrastructure!.fileUrl!,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const SizedBox(),
                      fit: BoxFit.cover,
                      height:  230,

                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width * (356/MediaQuery.of(context).size.width),
                    height: MediaQuery.of(context).size.width * (380/MediaQuery.of(context).size.width),
                    top: 180,
                    child: MatchDetailCard(
                      evenement: widget.evenement,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Réservez sur l'appli ou au",
              style: TypoStyle.textLabelStyleS18W700CBlack,
            ),
            const SizedBox(height: 4.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call_outlined,
                  color: GlobalColors.nextonbording,
                  size: 20,
                ),
                SizedBox(width: 4.0),
                Text(
                  "+221 33 800 00 00 / +221 77 800 00 00",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 98.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: GlobalColors.nextonbording,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: GlobalColors.nextonbording,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  context.goNamed("ticketReservation");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Réserver un ticket",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
