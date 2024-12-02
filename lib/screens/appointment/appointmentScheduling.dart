import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneau_personneDemandee.dart';
import 'package:mobile_pad_pa/providers/provider_objetRDV/provider_objetRDV.dart';
import 'package:mobile_pad_pa/providers/provider_personneDemande/provider_personneDemande.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';

class AppointmentSchedulingScreen extends StatefulWidget {
  const AppointmentSchedulingScreen({super.key});

  @override
  State<AppointmentSchedulingScreen> createState() =>
      _AppointmentSchedulingScreenState();
}

class _AppointmentSchedulingScreenState extends State<AppointmentSchedulingScreen> {
  final _schedulingFormKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool _isLoading = false;
  String? _message_check;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    Provider.of<AuthProvider>(context, listen: false);
    Provider.of<PersonneDemandeProvider>(context, listen: false);
    Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);
   // await  providerCreneau.getAllCreneauxByPersonneDemandee(context: context,  id: personneDemandeProvider.personneDemandeId, date: '2024-11-29T00:00:00', accessToken: authProvider.authLogin!.access, );
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      //locale: const Locale("fr", "FR"),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
        var personneDemandeProvider=Provider.of<PersonneDemandeProvider>(context, listen: false);
        var providerCreneau = Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);
        selectedDate = picked;
        rdvProvider.setDateRDV(selectedDate!);
        providerCreneau.getAllCreneauxByPersonneDemandee(context: context,  id: personneDemandeProvider.personneDemandeId, date: DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(picked), accessToken: authProvider!.authLogin!.access, );
        debugPrint('=====================> date rdv ${rdvProvider.dateRDV}');
      });
    }
  }

/*
  void _showCancellationSuccessDialog(BuildContext context) {
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Votre rendez-vous est enrégistré avec succès. Merci de patienter.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "SUCCESS",
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
                      if (rdvProvider.rdvAdded != null && rdvProvider.rdvAdded.containsKey('RDV')) {
                        String? rdvId = rdvProvider.rdvAdded['RDV']?['id'] as String?;
                        debugPrint('==============> ID RDV $rdvId');

                       // Navigator.of(context).pop(); // Ferme le dialogue

                        // Utilisez Future.microtask pour garantir que le context.go est appelé dans le bon contexte
                        Future.microtask(() {
                          context.pushNamed(
                            'accueil',
                          );
                        });
                      } else {
                        debugPrint('Erreur: rdvAdded est null ou ne contient pas la clé RDV');
                      }
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
*/

  void _showTimeSlotsDialog(BuildContext context) {
    var creneauProvider = Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);
    var listCreneauxPersonneDemandee = creneauProvider.lisCreneauPersonneDemandee;

    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(

          width: 1000,
          height: 1000,
          child: AlertDialog(
            title: const Center(
              child: Text(
                'Choisir un créneau horaire',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(0),
              child: Wrap(
                spacing: 12.0,
                runSpacing: 0.0,
                children: listCreneauxPersonneDemandee.map((creneau) {
                  // Vérification si creneau.debut et creneau.fin ne sont pas null
                  if (creneau.debut != null && creneau.fin != null) {
                    int startHour = int.parse(DateFormat('HH').format(creneau.debut!));
                    int startMinute = int.parse(DateFormat('mm').format(creneau.debut!));
                    int endHour = int.parse(DateFormat('HH').format(creneau.fin!));
                    int endMinute = int.parse(DateFormat('mm').format(creneau.fin!));

                    return _timeSlotButton(context, startHour, startMinute, endHour, endMinute, creneau);
                  } else {
                    // Si le créneau est invalide, ne rien afficher ou un message d'erreur
                    return const SizedBox.shrink(); // Éviter une erreur avec une case vide
                  }
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _timeSlotButton(BuildContext context, int startHour, int startMinute, int endHour, int endMinute, creneau) {
    var creneauProvider = Provider.of<CreneauPersonneDemandeProvider>(context, listen: false);


    return SizedBox(
      width: 110,  // Ajustez la largeur pour s'assurer que tout le texte tient sur une ligne
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,  // Réduire le padding autour du texte
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: GlobalColors.nextonbording,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () {
          creneauProvider.setGetedCreneau(creneau);
          setState(() {
            selectedTime = TimeOfDay(hour: startHour, minute: startMinute);
          });
          Navigator.pop(context);
        },
        child: Text(
          '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')} - '
              '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}',
          style: const TextStyle(color: GlobalColors.nextonbording),
          textAlign: TextAlign.center,  // Centrer le texte
        ),
      ),
    );
  }


  AuthProvider? authProvider;
  RDVProvider? rdvProvider;
  ObjetRDVProvider? objetRDVProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    objetRDVProvider = Provider.of<ObjetRDVProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    if (!_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    authProvider = Provider.of<AuthProvider>(context, listen: false);


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
      body: Form(
        key: _schedulingFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Choisir un créneau",
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
                          title: const Text("Choisir la date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 24,
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      if (selectedDate != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(selectedDate!),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
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
                          title: const Text("Choisir un créneau horaire",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                          onTap: () {
                            _showTimeSlotsDialog(context);
                          },
                        ),
                      ),
                      if (selectedTime != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: GlobalColors.nextonbording,
                                size: 24,
                              ),
                              Text(
                                'Créneau horaire sélectionné : ${selectedTime!.hour} h ${selectedTime!.minute} min',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      if (_message_check != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(
                            child: Text(
                              _message_check!,
                              style: TextStyle(
                                color: _message_check ==
                                        "Votre rendez-vous a été enregistré avec succès."
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 68),
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
                  onPressed: () async {
                    if (selectedDate == null || selectedTime == null) {
                      setState(() {
                        _message_check =
                            "Veuillez sélectionner une date et un créneau horaire.";
                      });
                    } else {
                     /* await creneauProvider.getCreneauById(
                          context: context,
                          id: '03cd80f9-39df-4b57-aba3-3ea5edcb1ff9',
                          accessToken: authProvider!.authLogin!.access);*/
                      context.goNamed('appointmentDetail');
                    }

                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Valider la date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
