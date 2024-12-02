import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneauEvent.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_infrastructure/provider_infrastruture.dart';
import 'package:mobile_pad_pa/providers/provider_typeEvenement/provider_typeEvenement.dart';
import 'package:provider/provider.dart';
import '../../components/inputs/myTextField.dart';
import '../../constantes/codeColors/codeColors.dart';

class AccueilReservation extends StatefulWidget {

  final Infrastructure infrastructure;
  const AccueilReservation({super.key, required this.infrastructure});

  @override
  _AccueilReservationState createState() => _AccueilReservationState();
}

class _AccueilReservationState extends State<AccueilReservation> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dateDebutController = TextEditingController();
  final TextEditingController _dateDebutControllerProv =
  TextEditingController();
  final TextEditingController _dateFinController = TextEditingController();
  final TextEditingController _dateFinControllerProv = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nomEventController = TextEditingController();

  bool _isLoading = true;
  String? _selectedItem = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  void dispose() {
    _dateDebutController.dispose();
    _dateDebutControllerProv.dispose();
    _dateFinController.dispose();
    _dateFinControllerProv.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void loadData() async {
 /*   var typeEvenementProvider =
    Provider.of<TypeEvenementProvider>(context, listen: false);*/
    Provider.of<AuthProvider>(context, listen: false);

   // await typeEvenementProvider.getAllTypeEvenements(context: context);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final _reservationFormKey = GlobalKey<FormState>();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController matchController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;


  String selectedLabel = '';


  String replaceSpaceWithT(String input) {
    return input.replaceFirst(' ', 'T');
  }

  void _selectStartTime(BuildContext context, DateTime dateTime) async {

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var creneauEventProvider =
    Provider.of<CreneauEventProvider>(context, listen: false);
    var infrastructureProvider =
    Provider.of<InfrastructureProvider>(context, listen: false);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        _dateDebutController.text = formatTimeOfDay(startTime!);
        DateTime combinedDateTime = DateTime(dateTime.year, dateTime.month,
            dateTime.day, startTime!.hour, startTime!.minute);
        _dateDebutControllerProv.text = formatDateTime(combinedDateTime);
      });
      if (_dateDebutControllerProv.text != '' &&
          _dateFinControllerProv.text != '' &&
          widget.infrastructure.id!= '') {
        var creneau = {
          "estDisponible": true,
          "dateDebut":
          DateTime.parse(_dateDebutControllerProv.text.replaceAll(' ', 'T'))
              .toIso8601String(),
          "dateFin":
          DateTime.parse(_dateFinControllerProv.text.replaceAll(' ', 'T'))
              .toIso8601String(),
          "infrastructure": {"id": widget.infrastructure.id}
        };
        debugPrint(
          "CreneaADD=================> $creneau",
        );
        await creneauEventProvider.addCreneauEvent(
            creneauEvent: creneau,
            accessToken: authProvider.authLogin!.access,
            context: context);
      }
    }
  }

  void _selectEndTime(BuildContext context, DateTime dateTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
        _dateFinController.text = formatTimeOfDay(endTime!);
        DateTime combinedDateTime = DateTime(dateTime.year, dateTime.month,
            dateTime.day, endTime!.hour, endTime!.minute);
        _dateFinControllerProv.text = formatDateTime(combinedDateTime);
      });
    }
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    var infrastructureProvider =
    Provider.of<InfrastructureProvider>(context, listen: false);
    debugPrint(
        "Sélection de date désactivée test ${infrastructureProvider.infraId}");

    if (infrastructureProvider.infraId == '') {
      debugPrint("Veuillez d'abord choisir l'infrastruture");
      return; // Si la condition n'est pas remplie, ne pas ouvrir le popup de date
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
        _isLoading = true;
        _dateDebutController.text = '';
        _dateFinController.text = '';
        _dateDebutControllerProv.text = '';
        _dateFinControllerProv.text = '';
        startTime = null;
        endTime = null;

      });

      var provider =
      Provider.of<InfrastructureProvider>(context, listen: false);
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      var creneauEventProvider =
      Provider.of<CreneauEventProvider>(context, listen: false);

      if (provider.infraId != '' && _dateController.text.isNotEmpty) {
        try {
          provider.setSingleInfraById(provider.infraId);

          await creneauEventProvider.getAllCreneauEventByDateAndInfra(
            context: context,
            id: provider.infraId,
            accessToken: authProvider.authLogin!.access,
            date: _dateController.text,
          );
        } catch (e) {
          debugPrint("Erreur lors de la récupération des créneaux: $e");
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        debugPrint("ID d'infrastructure ou date manquants.");
      }
    }
  }

  String formatTimeOfDay(TimeOfDay? time) {
    if (time == null) {
      // Handle the null case appropriately
      return '';
    }

    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour H : $minute';
  }

  String getFrenchMonth(String englishMonth) {
    switch (englishMonth) {
      case 'January':
        return 'Janvier';
      case 'February':
        return 'Février';
      case 'March':
        return 'Mars';
      case 'April':
        return 'Avril';
      case 'May':
        return 'Mai';
      case 'June':
        return 'Juin';
      case 'July':
        return 'Juillet';
      case 'August':
        return 'Août';
      case 'September':
        return 'Septembre';
      case 'October':
        return 'Octobre';
      case 'November':
        return 'Novembre';
      case 'December':
        return 'Décembre';
      default:
        throw ArgumentError('Invalid englishMonth argument');
    }
  }

  String getFrenchWeekday(String englishWeekday) {
    switch (englishWeekday) {
      case 'Monday':
        return 'Lundi';
      case 'Tuesday':
        return 'Mardi';
      case 'Wednesday':
        return 'Mercredi';
      case 'Thursday':
        return 'Jeudi';
      case 'Friday':
        return 'Vendredi';
      case 'Saturday':
        return 'Samedi';
      case 'Sunday':
        return 'Dimanche';
      default:
        throw ArgumentError('Invalid englishWeekday argument');
    }
  }

  @override
  Widget build(BuildContext context) {
    var creneauxEventProvider =
    Provider.of<CreneauEventProvider>(context, listen: false);
    var infraProvder =
    Provider.of<InfrastructureProvider>(context, listen: false);
    var authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    var liste = creneauxEventProvider.listCreneauxDateAndByInfra;
    var infra = infraProvder.infra;

    //selectedLabel = infra!.typeInfrastructure!.libelle!;
    selectedLabel = widget.infrastructure.typeInfrastructure!.libelle!;


    debugPrint("SELECTED label ======> $selectedLabel");


    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 2.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profil_accueil.png'),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bienvenue',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
              Text(
                '${authProvider.authLogin!.user.prenom}  ${authProvider.authLogin!.user.nom}',
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
          const SizedBox(width: 14),
        ],
        elevation: 30,
      ),
      body: Padding(
        padding:
        const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _reservationFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text('Que souhaitez-vous faire'),
                  ],
                ),
                const SizedBox(height: 1),

                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                //const SizedBox(height: 5.0),
                if (selectedLabel == widget.infrastructure.typeInfrastructure!.libelle!)
                  buildDynamicWidget()
                else
                  MyTextField(
                    label: "",
                    hintText: "Nom de l'événement",
                    controller: eventNameController,
                  ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: GlobalColors.nextonbording,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
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
                Visibility(
                  visible: infraProvder.infraId == '',
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Selectionnez d'abord l'infrastructure",
                      style: TextStyle(color: Colors.red),
                    ),
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
                        const SizedBox(width: 10.0),
                        Text(
                          '${getFrenchWeekday(DateFormat('EEEE').format(selectedDate!))} ${DateFormat('dd').format(selectedDate!)} ${getFrenchMonth(DateFormat('MMMM').format(selectedDate!))} ${DateFormat('yyyy').format(selectedDate!)}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10.0),
                Builder(
                  builder: (context) {
                    debugPrint("Liste1 length: ${liste.length}");

                    // Si la liste est vide, ne rien afficher
                    if (liste.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte à gauche
                        children: [
                          // Ajoutez le titre ici
                          const Text(
                            'Créneaux déjà pris',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10), // Espace entre le titre et le Wrap
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: liste
                                .where((time) => time != null) // Filtrer les valeurs non nulles
                                .map((time) => TimeSlotButton(
                                time:
                                "${DateFormat('HH').format(time.dateDebut!)}H${DateFormat('mm').format(time.dateDebut!)} - ${DateFormat('HH').format(time.dateFin!)}H${DateFormat('mm').format(time.dateFin!)}"))
                                .toList(),
                          ),
                        ],
                      ),
                    );

                  },
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Choisir un créneau",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'De',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),  // Animation de redimensionnement
                            constraints: const BoxConstraints(
                              minWidth: 45,
                              maxWidth: 90,  // Taille maximale quand le message de validation apparaît
                              minHeight: 25,
                              maxHeight: 70,  // Taille maximale quand le message de validation apparaît
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              onTap: () => _selectStartTime(context, DateTime.now()),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF128736)),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF128736)),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                hintText: '00 : 00',
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              controller: _dateDebutController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner l\'heure de début';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'A',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),  // Animation de redimensionnement
                            constraints: const BoxConstraints(
                              minWidth: 45,
                              maxWidth: 90,  // Taille maximale quand le message de validation apparaît
                              minHeight: 25,
                              maxHeight: 70,  // Taille maximale quand le message de validation apparaît
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              onTap: () => _selectEndTime(context, DateTime.now()),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF128736)),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF128736)),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                hintText: '00 : 00',
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              controller: _dateFinController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner l\'heure de début';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: startTime != null || endTime != null,
                    child: Row(
                      children: [
                        Visibility(
                          visible: startTime != null,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Heure de Début: ${startTime != null ? formatTimeOfDay(startTime!) : ""}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: GlobalColors.nextonbording,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 47,
                        ),
                        Visibility(
                          visible: endTime != null,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Heure de Fin: ${endTime != null ? formatTimeOfDay(endTime!) : ""}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: GlobalColors.nextonbording,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 12),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 3, bottom: 5),
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF128736)),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 68, vertical: 24.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: GlobalColors.nextonbording,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: GlobalColors.nextonbording,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      if (_reservationFormKey.currentState?.validate() ==
                          true) {
                        var creneauEventProvider =
                        Provider.of<CreneauEventProvider>(context,
                            listen: false);
                        var eventProvider = Provider.of<EvenementProvider>(
                            context,
                            listen: false);

                        creneauEventProvider.setDateDebut(replaceSpaceWithT(
                            '${_dateDebutControllerProv.text}:00'));
                        creneauEventProvider.setDateFIn(replaceSpaceWithT(
                            '${_dateFinControllerProv.text}:00'));
                        eventProvider
                            .setDescription(_descriptionController.text);
                        eventProvider.setNomEvent(_nomEventController.text);
                        eventProvider.setNomEvent(eventNameController.text);

                        debugPrint(
                            "Description event ==============> ${eventProvider.description}");
                        debugPrint(
                            "Nom event ==============> ${eventProvider.nomEvent}");

                        context.goNamed("paymentMod");
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Suivant",
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
      ),
    );
  }

  Widget buildDynamicWidget() {
    var typeEventProvider =
    Provider.of<TypeEvenementProvider>(context, listen: false);

    var typeEvenementList = typeEventProvider.listTypeEvenements.toList();

    if (selectedLabel == "Stade" || selectedLabel == "STADE") {
      return Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2),
        child: Column(
          children: [
            MyTextField(
              label: "",
              hintText: "Nom de l'événement",
              controller: eventNameController,
            ),
            ConstrainedBox(
              constraints:
              BoxConstraints.tight(const Size(double.infinity, 92)),
              child: FormField<dynamic>(
                builder: (FormFieldState<dynamic> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownSearch<dynamic>(
                        dropdownButtonProps: const DropdownButtonProps(
                            color: GlobalColors.primaryColor),
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                        ),
                        items: [
                          "--- Choisir l'événement à organiser ---",
                          ...typeEvenementList
                              .map((e) => "${e.libelle}")
                              .toList(),
                        ],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.0),
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                color: GlobalColors.nextonbording,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                color: GlobalColors.nextonbording,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF9FBFB),
                            labelStyle: const TextStyle(
                              color: Color(0xFF37393c),
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFF37393c),
                            ),
                          ),
                        ),
                        onChanged: (item) {
                          if (item !=
                              "--- Choisir l'événement à organiser ---") {
                            var select = typeEvenementList
                                .firstWhere((e) => "${e.libelle}" == item)
                                .id;
                            var typeEventProvider =
                            Provider.of<TypeEvenementProvider>(context,
                                listen: false);
                            typeEventProvider.setSingleTypeEventById(select!);
                            var authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            typeEventProvider.getTypeEvenementById(
                                context: context,
                                accessToken: authProvider.authLogin!.access,
                                id: typeEventProvider.typeEvenementId);
                            debugPrint(
                                "get lolou ${typeEventProvider.typeEvenementId}");
                            debugPrint("get lolou 1 $select");
                          }

                          setState(() {
                            matchController.text = item!;
                            _selectedItem = item;
                            debugPrint("SelectedItem ======> $_selectedItem");
                          });
                          debugPrint("Selected item: $item");
                        },
                        selectedItem: matchController.text.isEmpty
                            ? "--- Choisir l'événement à organiser ---"
                            : matchController.text,
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Visibility(
                          visible: _selectedItem !=
                              '--- Choisir l\'événement à organiser ---' &&
                              _selectedItem != '',
                          child: Consumer<TypeEvenementProvider>(
                            builder: (context, typeEventProvider, child) {
                              return Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.green,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${typeEventProvider.getedTypeEvenement?.duree?.toInt()} H :  ${typeEventProvider.getedTypeEvenement?.cout?.toInt()} FCFA',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return MyTextField(
        label: "",
        hintText: "Nom de l'événement",
        controller: eventNameController,
      );
    }
  }
}

class TimeSlotButton extends StatelessWidget {
  final String time;

  const TimeSlotButton({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red, width: 1),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
      child: Text(
        time,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}



class MyButton extends StatelessWidget {
  final Infrastructure infrastructure;
  final String label;
  final bool isActive;
  final Function(Infrastructure) onPressed;

  const MyButton({
    super.key,
    required this.infrastructure,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(infrastructure),
        style: ElevatedButton.styleFrom(
          foregroundColor: isActive ? Colors.white : Colors.black,
          backgroundColor: isActive ? Colors.green : Colors.grey[200],
        ),
        child: Text(label),
      ),
    );
  }
}
