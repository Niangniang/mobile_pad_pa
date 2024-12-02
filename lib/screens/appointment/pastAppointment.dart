import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import '../../constantes/codeColors/codeColors.dart';

class PastAppointmentScreen extends StatefulWidget {
  const PastAppointmentScreen({super.key});

  @override
  State<PastAppointmentScreen> createState() => _PastAppointmentScreenState();
}

class _PastAppointmentScreenState extends State<PastAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(
              left: 8.0), // Ajoutez du padding à gauche du CircleAvatar
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profil_accueil.png'),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  0.5), // Ajoute du padding à gauche et à droite du titre
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Pour aligner le texte à gauche
            mainAxisSize:
                MainAxisSize.min, // Pour empêcher la colonne de s'étendre
            children: [
              Text(
                'Bienvenue',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
              Text(
                'Macky Dramé',
                style: TypoStyle.textLabelStyleS22W600CGreen1,
              ),
            ],
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
              // Action quand l'icône est pressée
            },
          ),
          const SizedBox(
              width: 14), // Ajoute du padding à droite du dernier élément
        ],
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  context.goNamed("appointmentSubject");
                },
                child: const Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ajoutez cette ligne pour un bouton flexible
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.deepOrangeAccent,
                      size: 32,
                    ),
                    SizedBox(width: 4), // Espace entre l'icône et le texte
                    Text(
                      "Prendre un rendez-vous",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: CupertinoColors.lightBackgroundGray,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      context.goNamed("appointment");
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Mes rendez-vous",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  TextButton(
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
                      context.goNamed("pastAppointment");
                    },
                    child:  Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (16/MediaQuery.of(context).size.width),
                        ),
                        const Text(
                          "rendez-vous passés",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // Ajoutez cet Expanded autour de votre ListView
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors
                            .lightBackgroundGray, // Couleur de la bordure
                        width: 1.0, // Largeur de la bordure
                      ),
                      borderRadius:
                          BorderRadius.circular(8.0), // Rayon des coins
                    ),
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width * (50/MediaQuery.of(context).size.width) ,
                        height: MediaQuery.of(context).size.width * (50/MediaQuery.of(context).size.width),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/appointment-4.png',
                            ),
                          ),
                        ),
                      ),
                      title: const Text("Demande de financement",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rendez-vous physique",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vendredi 15 Mars 2024",
                                style: TextStyle(
                                    color: CupertinoColors.inactiveGray),
                              ),
                              Text(
                                "9:45",
                                style: TextStyle(
                                    color: CupertinoColors.inactiveGray),
                              )
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        debugPrint('Tapped on 1 ==========>');
                      },
                    ),
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
