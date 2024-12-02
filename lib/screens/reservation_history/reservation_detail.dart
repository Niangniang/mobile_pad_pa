import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:provider/provider.dart';
import '../../components/cards/matchDetailCard.dart';
import '../../constantes/codeColors/codeColors.dart';

class ReservationHistoryDetail extends StatefulWidget {
  final String id;

  const ReservationHistoryDetail({super.key, required this.id});

  @override
  State<ReservationHistoryDetail> createState() =>
      _ReservationHistoryDetailState();
}

class _ReservationHistoryDetailState extends State<ReservationHistoryDetail> {
  late Future<void> _fetchEvenementFuture;

  @override
  void initState() {
    super.initState();
    _fetchEvenementFuture = _fetchEvenement();
  }

  Future<void> _fetchEvenement() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<EvenementProvider>(context, listen: false)
        .getEvenementById(
      context: context,
      accessToken: authProvider.authLogin!.access,
      id: widget.id,
    );
  }

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
              context.pop();
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
      body: FutureBuilder<void>(
        future: _fetchEvenementFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement des données'));
          }

          var evenementProvider = Provider.of<EvenementProvider>(context);
          var evenement = evenementProvider.getedEvent;

          if (evenement == null) {
            return const Center(child: Text('Aucun événement trouvé'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.71,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // Prend toute la largeur de l'écran
                          height: 230,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: evenement.creneau!.infrastructure!.fileUrl !=
                                      null &&
                                  evenement.creneau!.infrastructure!.fileUrl!
                                      .isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: evenement
                                      .creneau!.infrastructure!.fileUrl!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(), // Indicateur de chargement
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(), // Affiche un widget vide en cas d'erreur
                                  fit: BoxFit
                                      .cover, // L'image couvre toute la largeur
                                )
                              : const SizedBox(), // Ne rien afficher si fileUrl est null ou vide
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.45,
                        top: 180,

                        child: MatchDetailCard(evenement: evenement),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 48.0),
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
                    onPressed: () => _showTicketDialog(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Afficher le reçu de la réservation",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTicketDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/recu.png',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement download action here
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Télécharger"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
