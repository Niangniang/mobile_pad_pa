import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau_personneDemandee.dart';
import 'package:mobile_pad_pa/providers/provider_objetRDV/provider_objetRDV.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';

class AppointmentDetailScreen extends StatefulWidget {
  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  bool _isLoading = true;
  bool _localeInitialized = true;

  AuthProvider? authProvider;
  RDVProvider? rdvProvider;
  ObjetRDVProvider? objetRDVProvider;
  CreneauPersonneDemandeProvider? creneauProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    objetRDVProvider = Provider.of<ObjetRDVProvider>(context, listen: false);
    creneauProvider = Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);
    //creneauProvider.getCreneauById(context: context, id: , accessToken: accessToken)
    await initializeDateFormatting('fr_FR', null);

    if (mounted) {
      setState(() {
        _isLoading = false;
        _localeInitialized = false;
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Succès"),
          content:
              const Text("Votre rendez-vous a été enregistré avec succès."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                context.goNamed('appointment');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitRDV() async {
    if (authProvider == null ||
        rdvProvider == null ||
        objetRDVProvider == null) {
      debugPrint("One of the providers is null");
      return;
    }
    try {
      Map<String, dynamic> dataRDV = {
        "date":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(rdvProvider!.dateRDV!),
        "description": rdvProvider?.description,
        "age": 18,
        "secteurAtivites": "",
        "typeRdv": rdvProvider?.typeRDV,
        "utilisateur": authProvider?.authLogin?.user.id,
        "objetRDV": {"id": objetRDVProvider?.objetRDVId},
        "creneau": {"id": creneauProvider?.getedCreneau?.id},
        "etatRdv": 'Pris',
      };

      debugPrint("Data rdv send: $dataRDV");



      await rdvProvider!.addRDV(
          rdv: dataRDV,
          context: context,
          accessToken: authProvider!.authLogin!.access);

      _showSuccessDialog(context);
    } catch (error) {
      debugPrint("Erreur lors de l'ajout du paiement: $error");
    }
  }

  // Méthode pour afficher la boîte de dialogue de confirmation d'annulation
  void _showCancelAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              "Voulez-vous vraiment annuler le rendez-vous ?",
              style: TypoStyle.textLabelStyleS16W500CBlack1,
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3, // Ajustez le pourcentage pour la largeur
                    height:  MediaQuery.of(context).size.height * 0.05, // Hauteur du bouton "Annuler"
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: GlobalColors.orangeColor,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Annuler",
                        style: TextStyle(color: GlobalColors.orangeColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Espacement entre les boutons
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3, // Ajustez le pourcentage pour la largeur
                    height: MediaQuery.of(context).size.height * 0.05, // Hauteur du bouton "Confirmer"
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: GlobalColors.nextonbording,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Logique pour annuler le rendez-vous
                        Navigator.of(context).pop();
                        _showCancellationSuccessDialog(context);
                      },
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ],
        );
      },
    );
  }

  // Méthode pour afficher la boîte de dialogue de confirmation de l'annulation réussie
  void _showCancellationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Votre rendez-vous a bien été annulé.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Merci de prendre un nouveau",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Rendez-vous",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: GlobalColors.nextonbording,
                    size: 24,
                  ),
                ],
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 84),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: GlobalColors.nextonbording,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      context.goNamed("appointment");
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _localeInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    var creneauProvider = Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);

    DateFormat formatter = DateFormat('EEEE d MMMM yyyy', 'fr_FR');

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors
                        .lightBackgroundGray, // Couleur de la bordure
                    width: 1.0, // Largeur de la bordure
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 16, right: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width * (240/MediaQuery.of(context).size.width),
                        height: MediaQuery.of(context).size.height * (200/MediaQuery.of(context).size.height),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "${creneauProvider.getedCreneau?.personneDemande?.fileUrl}"),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 8, right: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_2_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "${creneauProvider.getedCreneau?.personneDemande?.prenom} ${creneauProvider?.getedCreneau?.personneDemande?.nom}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.cases_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "${creneauProvider.getedCreneau?.personneDemande?.nomPoste}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.grid_view_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "${rdvProvider.typeRDV}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.library_books_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "${rdvProvider.objetRDVItem}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.chat_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  "${rdvProvider.description}",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                // 'Lundi le 02 02 2024',
                                formatter.format(
                                    creneauProvider.getedCreneau!.date!),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                // "date debut date fin",
                                "${DateFormat("HH:MM").format(creneauProvider.getedCreneau!.debut!)}  à  ${DateFormat("HH:MM").format(creneauProvider.getedCreneau!.fin!)} ",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05, // Hauteur du bouton "Annuler"
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.indigo,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          _showCancelAppointmentDialog(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Annuler RDV",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.backspace_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Espacement entre les deux boutons
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05, // Hauteur du bouton "Valider"
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: GlobalColors.nextonbording,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          _submitRDV();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Valider",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
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
