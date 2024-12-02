import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';
import '../../constantes/textStyles/textStyle.dart';
import '../../models/model_evenement/model_evenement.dart';

class MatchDetailCard extends StatelessWidget {
  final Evenement evenement;

  const MatchDetailCard({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    if (evenement == null) {
      return const Center(child: Text('Aucun événement trouvé'));
    } else {
      debugPrint("Address event ======> ${evenement.toJson()}");
    }

    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left:20,right:20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: CupertinoColors.lightBackgroundGray,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 4.0, right: 15.0),

              child: Text(

                evenement.nomEvenement ?? "Pas de nom d'évènement trouvé",
                style: const TextStyle(
                  color: GlobalColors.nextonbording,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Organisateur",
                      style: TypoStyle.textLabelStyleS16W500CBlack1),
                  const SizedBox(height: 4.0),
                  Text(
                    "${authProvider.authLogin?.user.prenom ?? 'Prénom inconnu'} ${authProvider.authLogin?.user?.nom ?? 'Nom inconnu'}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text("Description de l'événement",
                      style: TypoStyle.textLabelStyleS16W500CBlack1),
                  const SizedBox(height: 4.0),
                  Text(
                    evenement.description ?? 'Description non disponible',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  const SizedBox(height: 8.0),
                  const Text("Lieu :",
                      style: TypoStyle.textLabelStyleS16W500CBlack1),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: GlobalColors.nextonbording,
                        size: 20,
                      ),
                      Expanded(
                        child: Text(
                          evenement.creneau?.infrastructure?.adresse ??
                              'Adresse inconnue',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Date :",
                            style: TypoStyle.textLabelStyleS16W500CBlack1),
                        SizedBox(width: 145.0),
                        Text("Heure :",
                            style: TypoStyle.textLabelStyleS16W500CBlack1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: GlobalColors.nextonbording,
                              size: 20,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              evenement.dateInsertion != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(evenement.dateInsertion!)
                                  : 'Date inconnue',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: GlobalColors.nextonbording,
                              size: 20,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              evenement.creneau?.dateDebut != null &&
                                      evenement.creneau?.dateFin != null
                                  ? "${DateFormat('HH:mm').format(evenement.creneau!.dateDebut!)} à ${DateFormat('HH:mm').format(evenement.creneau!.dateFin!)}"
                                  : 'Heure inconnue',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
