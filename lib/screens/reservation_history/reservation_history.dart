import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/screens/reservation_history/ticketList.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';
import 'reservationList.dart';

class ReservationHistoryScreen extends StatefulWidget {
  const ReservationHistoryScreen({super.key});

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  bool showTicketHistory = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * (45 / MediaQuery.of(context).size.height),  // Hauteur de l'image
                  width: MediaQuery.of(context).size.width * (45 / MediaQuery.of(context).size.width),   // Largeur de l'image (égale à la hauteur pour un cercle)
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),  // Rayon de moitié pour rendre l'image circulaire
                    child: authProvider.authLogin?.user.attachement != null
                        ? CachedNetworkImage(
                      imageUrl: authProvider.authLogin!.user.attachement!,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    )
                        : const Icon(
                      Icons.person, // Icône par défaut si l'image n'existe pas
                      size: 35,
                    ),
                  ),
                );
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bienvenue',
                      style: TypoStyle.textLabelStyleS18W600CBlack1,
                    ),
                    Text(
                      "${authProvider.authLogin?.user.prenom} ${authProvider.authLogin?.user.nom}",
                      style: TypoStyle.textLabelStyleS22W600CGreen1,
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                // Action when the icon is pressed
              },
            ),
            const SizedBox(width: 14),
          ],
          elevation: 30,
        ),
        body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: !showTicketHistory
                          ? GlobalColors.nextonbording
                          : CupertinoColors.lightBackgroundGray,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: CupertinoColors.lightBackgroundGray,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          showTicketHistory = false;
                        });
                      }
                    },
                    child: Text(
                      "Mes réservations",
                      style: TextStyle(
                        color:
                            !showTicketHistory ? Colors.white : Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: showTicketHistory
                          ? GlobalColors.nextonbording
                          : CupertinoColors.lightBackgroundGray,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: CupertinoColors.lightBackgroundGray,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          showTicketHistory = true;
                        });
                      }
                    },
                    child: Text(
                      "Historique tickets",
                      style: TextStyle(
                        color:
                            showTicketHistory ? Colors.white : Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: showTicketHistory
                    ? const TicketHistoryList()
                    : const ReservationList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
