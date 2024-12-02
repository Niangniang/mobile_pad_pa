import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';

import '../../constantes/codeColors/codeColors.dart';

class AppointmentTypeScreen extends StatefulWidget {
  const AppointmentTypeScreen({super.key});

  @override
  State<AppointmentTypeScreen> createState() => _AppointmentTypeScreenState();
}

class _AppointmentTypeScreenState extends State<AppointmentTypeScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });

  }

  void loadData() async {
    Provider.of<RDVProvider>(context,listen: false);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {


    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);

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
            crossAxisAlignment:
                CrossAxisAlignment.start, // Pour aligner le texte à gauche
            mainAxisSize:
                MainAxisSize.min, // Pour empêcher la colonne de s'étendre
            children: [
              Text(
                'Prendre un rendez-vous',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
            ],
          ),
        ),
        elevation: 30,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Quel type de rendez-vous souhaitez-vous ?",
                    style: TypoStyle.textLabelStyleS16W500CBlack1,
                  ),
                ),
                Expanded(
                  // Ajoutez cet Expanded autour de votre ListView
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
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
                            leading: const Icon(
                              Icons.group,
                              color: CupertinoColors.systemBlue,
                              size: 32,
                            ),
                            title: const Text("Rendez-vous physique",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () {
                              debugPrint('Tapped on 1 ==========>');
                              rdvProvider.setTypeRDV('Présentiel');
                              debugPrint('Tapped on 3 ==========> ${rdvProvider.typeRDV} ');
                              context.goNamed("appointmentScheduling");
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            leading: const Icon(
                              Icons.call_outlined,
                              color: GlobalColors.nextonbording,
                              size: 32,
                            ),
                            title: const Text("Entretien téléphonique",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () {
                              debugPrint('Tapped on 2 ==========>');
                              rdvProvider.setTypeRDV('Ligne');
                              debugPrint('Tapped on 2 ==========> ${rdvProvider.typeRDV} ');
                              context.goNamed("appointmentScheduling");
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            leading: const Icon(
                              Icons.video_camera_back_outlined,
                              color: Colors.deepOrangeAccent,
                              size: 32,
                            ),
                            title: const Text("Réunion sur Zoom",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () {
                              debugPrint('Tapped on 3 ==========>');
                              context.goNamed("appointmentScheduling");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      )
    );
  }
}
