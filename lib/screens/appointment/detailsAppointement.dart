import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';


class RendezVousDetailPage extends StatefulWidget {

  final RDV appointment;
  const RendezVousDetailPage({super.key, required this.appointment});

  @override
  State<RendezVousDetailPage> createState() => _RendezVousDetailPageState();
}

class _RendezVousDetailPageState extends State<RendezVousDetailPage> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  bool _isLoading = true;
  bool _isButtonLoading = false;
  AuthProvider? authProvider;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    Provider.of<AuthProvider>(context, listen: false);
    Provider.of<RDVProvider>(context, listen: false);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onPressed() async {
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isButtonLoading = true;  // Démarre le loader
    });

    try {
      // Appelez la fonction d'annulation de rendez-vous
      await rdvProvider.annulerRDV(
        id: widget.appointment.id!,
        context: context,
        accessToken: authProvider.authLogin!.access,
      );

      // Si le pop-up de confirmation est encore ouvert, fermez-le
      if (mounted && Navigator.canPop(context)) {
        GoRouter.of(context).pop();
        // Ferme le pop-up
      }

      // Si la page actuelle peut encore être fermée, revenez en arrière
      if (mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();  // Ferme la page actuelle
      }

    } catch (error) {
      debugPrint("Erreur lors de l'annulation du RDV: $error");
    } finally {
      if (mounted) {
        setState(() {
          _isButtonLoading = false;  // Arrête le loader après la requête
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if(_isLoading){
      return const Center(child: CircularProgressIndicator());
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Détail du rendez-vous'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                SizedBox(
                width: 500,  // Définir la largeur de l'image
                height: 240, // Définir la hauteur de l'image
                child: widget.appointment.creneau!.personneDemande!.fileUrl != null
                    ? CachedNetworkImage(
                  imageUrl: widget.appointment.creneau!.personneDemande!.fileUrl!,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                )
                    : const Icon(
                  Icons.person, // Icône par défaut si l'image n'existe pas
                  size: 35,
                ),
              ),
                  const SizedBox(height: 16.0),
                  // Person Info
                   Row(
                    children: [
                      const Icon(Icons.person, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text(
                        '${widget.appointment.creneau!.personneDemande!.prenom}  ${widget.appointment.creneau!.personneDemande!.nom}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Title
                   Row(
                    children: [
                      const Icon(Icons.account_balance, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text('${widget.appointment.creneau!.personneDemande!.nomPoste}'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Type de rendez-vous
                  Row(
                    children: [
                      const Icon(Icons.meeting_room, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text('${widget.appointment.typeRdv}'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Objet de la demande
                  Row(
                    children: [
                      const Icon(Icons.assignment, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text(widget.appointment.objetRDV!.objet!),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Description
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.chat, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          "${widget.appointment.description}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Date
                   Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text(DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(widget.appointment.date!)),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Heure
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.green),
                      const SizedBox(width: 8.0),
                      Text(
                        '${DateFormat("HH").format(widget.appointment.creneau!.debut!)} H '
                            '${DateFormat("mm").format(widget.appointment.creneau!.debut!)} min',
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Bouton "Annuler le rendez-vous"
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                icon: const Icon(Icons.cancel, color: Colors.white),
                label: const Text('Annuler le rendez-vous', style: TextStyle(color: Colors.white),),
                onPressed: () => _showCancelDialog(context),
              ),
            ),
          ],
        ),
      ),
    );

  }
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Souhaitez-vous vraiment annuler\nVotre rendez-vous',
            textAlign: TextAlign.center,
            style: TypoStyle.textLabelStyleS14W400CBlack,
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            SizedBox(
              width: 105,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Colors.redAccent, // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                },
                child:  Text('Annuler', style: TypoStyle.textLabelStyleS14W400CRed),
              ),
            ),
          //  const SizedBox(width: 1),
            SizedBox(
              width: 115,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Couleur du bouton confirmer
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Colors.green, // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                ),
                onPressed: _isButtonLoading
                    ? null  // Désactive le bouton pendant le chargement
                    : () async {
                  await _onPressed(); // Appelle la méthode pour annuler le RDV
                },

                // Affiche le loader si isLoading est true, sinon affiche "Confirmer"
                child: _isButtonLoading
                    ? const SizedBox(
                  width: 15,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white, // Couleur du loader
                    strokeWidth: 2.0,
                  ),
                )
                    : const Text('Confirmer', style: TypoStyle.textLabelStyleS14W400CWhite),
              ),
            )
          ],
        );
      },
    );
  }
}



