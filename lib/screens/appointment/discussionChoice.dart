import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_personneDemande/provider_personneDemande.dart';
import 'package:provider/provider.dart';

class DiscussionChoiceScreen extends StatefulWidget {
  const DiscussionChoiceScreen({super.key});

  @override
  State<DiscussionChoiceScreen> createState() => _DiscussionChoiceScreenState();
}

class _DiscussionChoiceScreenState extends State<DiscussionChoiceScreen> {


  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });

  }

  void loadData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var personneDemandeProvider = Provider.of<PersonneDemandeProvider>(context, listen: false);
    await personneDemandeProvider.getAllPersonneDemande(context: context, accessToken: authProvider.authLogin!.access );
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    var personneDemandeProvider = Provider.of<PersonneDemandeProvider>(context, listen: false);



    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 8.0), // Ajoutez du padding à gauche du CircleAvatar
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
                    "A qui souhaitez-vous parler ?",
                    style: TypoStyle.textLabelStyleS16W500CBlack1,
                  ),
                ),
                Expanded(

                  child: Consumer<PersonneDemandeProvider>(
                    builder: (context, provider, child) {
                      return ListView(
                        children: provider.listPersonneDemnade.map((person) {

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.lightBackgroundGray,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                minRadius: 30,
                                maxRadius: 30,
                                backgroundImage: CachedNetworkImageProvider("${person.fileUrl}"),
                                //backgroundImage: AssetImage("assets/images/appointment-1.png"),
                              ),
                              title: Text("${person.prenom} ${person.nom}", style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text("${person.nomPoste}", style: const TextStyle(fontWeight: FontWeight.w400)),
                                ],
                              ),
                              onTap: () {
                                debugPrint('Tapped on ${person.id}');
                                personneDemandeProvider.setSinglePersonneDemandeById("${person.id}");
                                context.goNamed("appointmentType");
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  // Ajoutez cet Expanded autour de votre ListView
                  /*child: ListView(
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
                      leading: const CircleAvatar(
                        minRadius: 30,
                        maxRadius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/appointment-4.png',
                        ),
                      ),
                      title: const Text("Aboubacar Djamila Sané",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text("Maire de la commune",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                      onTap: () {
                        debugPrint('Tapped on 1 ==========>');
                        context.goNamed("appointmentType");
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
                      leading: const CircleAvatar(
                        minRadius: 30,
                        maxRadius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/appointment-1.png',
                        ),
                      ),
                      title: const Text("Abdoulaye Fall",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text("Sécrétaire du maire",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                      onTap: () {
                        debugPrint('Tapped on 2 ==========>');
                        context.goNamed("appointmentType");
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
                      leading: const CircleAvatar(
                        minRadius: 30,
                        maxRadius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/appointment-2.png',
                        ),
                      ),
                      title: const Text("Ndeye Astou Diop",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text("Assistante du maire",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                      onTap: () {
                        debugPrint('Tapped on 3 ==========>');
                        context.goNamed("appointmentType");
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
                      leading: const CircleAvatar(
                        minRadius: 30,
                        maxRadius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/appointment-3.png',
                        ),
                      ),
                      title: const Text("Pascal Ndaw",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text("Responsable Jeunesse Culture",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                      onTap: () {
                        debugPrint('Tapped on 4 ==========>');
                        context.goNamed("appointmentType");
                      },
                    ),
                  ),
                ],
              ),*/
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
