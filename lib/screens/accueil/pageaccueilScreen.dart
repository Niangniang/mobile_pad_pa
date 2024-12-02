import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/main.dart';
import 'package:mobile_pad_pa/models/model_announcement/model_announcement.dart';
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_announcement/provider_announcement.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_firebase/provider_firebase.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:mobile_pad_pa/providers/provider_typeEvenement/provider_typeEvenement.dart';
import 'package:mobile_pad_pa/providers/provider_typeInfrastructure/provider_typeInfrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_utilisateur/provider_utilisateur.dart';
import 'package:mobile_pad_pa/providers/provider_websocket/provider_websocket.dart';
import 'package:mobile_pad_pa/services/service_firebase/service_firebase.dart';
import 'package:provider/provider.dart';
import '../../components/button/categoryButtonAccueil.dart';
import '../../components/button/infraButton.dart';
import '../../components/cards/appointmentCard.dart';
import '../../components/cards/itemAnnonceCard.dart';
import '../../components/cards/itemEventCard.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../components/searchBarField.dart';
import '../../utils/formatTime.dart';

class PageaccueilScreen extends StatefulWidget {
  const PageaccueilScreen({super.key});
  @override
  State<PageaccueilScreen> createState() => _PageaccueilScreenState();
}

class _PageaccueilScreenState extends State<PageaccueilScreen> {
  String selectedCategory = "Tous";
  bool _isLoading = true;

  final ScrollController _scrollControllerRdvSection = ScrollController();
  final ScrollController _scrollControllerAnnonceSection = ScrollController();
  final ScrollController _scrollControllerEventSection = ScrollController();
  final ScrollController _scrollControllerInfraSection = ScrollController();

  void _scrollLeft() {
    _scrollControllerAnnonceSection.animateTo(
      _scrollControllerAnnonceSection.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeftRdv() {
    _scrollControllerRdvSection.animateTo(
      _scrollControllerRdvSection.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeftEvent() {
    _scrollControllerEventSection.animateTo(
      _scrollControllerEventSection.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollControllerAnnonceSection.animateTo(
      _scrollControllerAnnonceSection.offset +
          200, // Adjust the scroll offset as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeftInfra() {
    _scrollControllerInfraSection.animateTo(
      _scrollControllerInfraSection.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRightInfra() {
    _scrollControllerInfraSection.animateTo(
      _scrollControllerInfraSection.offset +
          200, // Adjust the scroll offset as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRightRdv() {
    _scrollControllerRdvSection.animateTo(
      _scrollControllerRdvSection.offset +
          200, // Adjust the scroll offset as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRightEvent() {
    _scrollControllerEventSection.animateTo(
      _scrollControllerEventSection.offset +
          200, // Adjust the scroll offset as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  void _selectNewProfilePicture() async {
    var userProvider  = Provider.of<UtilisateurProvider>(context, listen: false);
    var authProvider  = Provider.of<AuthProvider>(context, listen: false);

    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);


    if (image != null) {

      // Supposons que `image` soit un XFile? qui est le fichier sélectionné
      if (image != null) {
        File imageFile = File(image.path);
        userProvider.updateUserPicture(
          context: context,
          accessToken: authProvider.authLogin!.access,
          id: authProvider.authLogin!.user.id!,
          imageFile: imageFile,
        );
      }

      setState(() {
        // Mettre à jour l'avatar avec la nouvelle image
       // _profileImage = image.path; // Mettre à jour la variable qui stocke l'image
      });
    }
  }




  @override
  void dispose() {
    _scrollControllerRdvSection.dispose();
    _scrollControllerAnnonceSection.dispose();
    _scrollControllerEventSection.dispose();
    _scrollControllerInfraSection.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    await initializeDateFormatting('fr_FR', null);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var eventProvider = Provider.of<EvenementProvider>(context, listen: false);
    var typeEventProvider =
        Provider.of<TypeEvenementProvider>(context, listen: false);
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    var typeInfraProvider =
        Provider.of<TypeInfrastructureProvider>(context, listen: false);
    var announcementProvider =
        Provider.of<AnnouncementProvider>(context, listen: false);
    Provider.of<UtilisateurProvider>(context, listen: false);


    var firebaseProvider =
    Provider.of<FirebaseProvider>(context, listen: false);


    debugPrint("Tokennnn 1 ======>${firebaseProvider.tokenFirebase} ");

    Map<String, dynamic> data = {
      "registration_tokens_firebase":  firebaseProvider.tokenFirebase
    };
    ServiceFirebase().saveTokensFirebase(data , authProvider.authLogin!.access);


    await eventProvider.getAllEvenements(context: context);
    await announcementProvider.getAllAnnonces(
        context: context, accessToken: authProvider.authLogin!.access);
    await typeInfraProvider.getAllTypeInfrastructures(
        context: context, accessToken: authProvider.authLogin!.access);
    await typeEventProvider.getAllTypeEvenements(context: context);
    await rdvProvider.getAllRDVsByUser(
        context: context,
        accessToken: authProvider.authLogin!.access,
        id: authProvider.authLogin!.user.id!);


    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    var typeInfraProvider =
        Provider.of<TypeInfrastructureProvider>(context, listen: false);
    var typeEventProvider =
        Provider.of<TypeEvenementProvider>(context, listen: true);



    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.nextonbording,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: GestureDetector(
              onTap: () {
                // Action pour changer la photo, par exemple, ouvrir une galerie ou utiliser la caméra
                _selectNewProfilePicture();
              },
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.authLogin!.user.attachement == null
                      ? CircleAvatar(
                    backgroundColor: Colors.grey.shade800, // Couleur de fond de l'avatar
                    child: Text(
                      // Extraire la première lettre du prénom et du nom
                      "${authProvider.authLogin!.user.prenom?[0]}${authProvider.authLogin!.user.nom?[0]}".toUpperCase(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                      : Stack(
                    children: [
                      CircleAvatar(
                        radius: 28, // Taille du CircleAvatar
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.network(
                            authProvider.authLogin!.user.attachement!,
                            fit: BoxFit.cover,
                            width: 40, // Ajustez la largeur de l'image pour s'adapter au cercle
                            height: 40, // Ajustez la hauteur de l'image pour s'adapter au cercle
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                    strokeWidth: 0.5,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error); // Icône affichée en cas d'erreur de chargement
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Action pour changer la photo, par exemple, ouvrir une galerie ou utiliser la caméra
                            _selectNewProfilePicture();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3), // Marge autour de l'icône
                            decoration: const BoxDecoration(
                              color: Colors.blue, // Fond de l'icône
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 7, // Taille de l'icône
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bienvenue',
                  style: TypoStyle.textLabelStyleS12W400CWhite,
                ),
                Text(
                  "${authProvider.authLogin?.user.prenom} ${authProvider.authLogin?.user.nom}",
                  style: TypoStyle.textLabelStyleS14W600CWhite,
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                context.goNamed("notification");
              },
            ),
            const SizedBox(width: 14),
          ],
          elevation: 0,
        ),

        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: GlobalColors.nextonbording, // Couleur de fond verte
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const SearchBarField(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, right: 16, bottom: 10),
                child: Column(
                  children: [
                    _buildRDVSection(context, rdvProvider),
                    const SizedBox(height: 18),
                    _buildInfrastructuresSection(context, typeInfraProvider),
                    const SizedBox(height: 18),
                    _buildAnnoncesSection(),
                    const SizedBox(height: 18),
                    _buildCategoriesSection(context, typeEventProvider),
                    const SizedBox(height: 18),
                    //_buildEventsSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRDVSection(BuildContext context, RDVProvider rdvProvider) {
    return Consumer<RDVProvider>(
      builder: (context, rdvProvider, child) {
        var listRDVUser = rdvProvider.listRDVsByUser;

        return Card(
          elevation: 0,
          surfaceTintColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Adjust the radius here
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.01,
              ),
              color: const Color(0xFFF7F6FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 5,
                  offset: const Offset(-3, 0),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 5,
                  offset: const Offset(3, 0),
                ),
              ], // Coins arrondis
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rendez-vous',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 8.0),
                          Image(
                              image:
                                  AssetImage("assets/images/Appointment.png"))
                        ],
                      ),
                      Text(
                        'Voir tout',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: GlobalColors.nextonbording),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 0.0),
                  child:
                      listRDVUser.isEmpty
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Vous n'avez pas encore de rendez-vous",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: GlobalColors.nextonbording,
                                        width: 2.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.goNamed("appointmentSubject");
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: GlobalColors.nextonbording,
                                        size: 32,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Prendre un rendez-vous",
                                        style: TextStyle(
                                          color:
                                              GlobalColors.nextonbording,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_left),
                                    color: GlobalColors.nextonbording,
                                    onPressed:
                                        _scrollLeftRdv, // Scroll to the left
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * (140/MediaQuery.of(context).size.height),
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      controller: _scrollControllerRdvSection,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listRDVUser.length,
                                      itemBuilder: (context, index) {
                                        var rdvUser = listRDVUser[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0, right: 8),
                                          child: AppointmentCard(
                                            name:
                                                "${rdvUser.user!.prenom} ${rdvUser.user!.nom}",
                                            description:
                                                "${rdvUser.typeRdv}",
                                            objetRDV:
                                                "${rdvUser.objetRDV?.objet}",
                                            status: "${rdvUser.etatRdv}",
                                            date: DateFormat(
                                                    "d MMM yyyy", 'fr_FR')
                                                .format(rdvUser.date!),
                                            creneauDebut: formatTime(
                                                rdvUser.creneau?.debut),
                                            creneauFin: formatTime(
                                                rdvUser.creneau?.fin),
                                            image:
                                                "${rdvUser.creneau?.personneDemande?.fileUrl}",
                                            withWhom:
                                                "${rdvUser.creneau!.personneDemande!.prenom} ${rdvUser.creneau!.personneDemande!.nom}",
                                            nomPoste:
                                                "${rdvUser.creneau?.personneDemande?.nomPoste}",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_right),
                                    color: GlobalColors.nextonbording,
                                    onPressed:
                                        _scrollRightRdv, // Scroll to the right
                                  ),
                                ),
                              ],
                            ),

                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfrastructuresSection(
      BuildContext context, TypeInfrastructureProvider typeInfraProvider) {
    var listTypeInfras = typeInfraProvider.listTypeInfrastructures;

    return Card(
      elevation: 0,
      surfaceTintColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Adjust the radius here
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.01,
          ),
          color: const Color(0xFFF7F6FA),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(-3, 0),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(3, 0),
            ),
          ], // Coins arrondis
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Text(
                    'Infrastructures',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(width: 8.0),
                  Image(image: AssetImage("assets/images/Stadium.png"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_left),
                      color: GlobalColors.nextonbording,
                      onPressed: _scrollLeftInfra, // Scroll to the left
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height:MediaQuery.of(context).size.height * (80/MediaQuery.of(context).size.height),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        controller: _scrollControllerInfraSection,
                        scrollDirection: Axis.horizontal,
                        itemCount: listTypeInfras.length,
                        itemBuilder: (context, index) {
                          var typeInfra = listTypeInfras[index];
                          return InfraButton(
                            intitule: typeInfra.libelle!,
                            fileUrl : typeInfra.fileUrl!,
                            onTap: () {
                              // typeInfraProvider.setTypeInfraId(typeInfra.id!);
                              context.goNamed(
                                "listInfras",
                                extra: typeInfra,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      color: GlobalColors.nextonbording,
                      onPressed: _scrollRightInfra, // Scroll to the right
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

  Widget _buildAnnoncesSection() {
    final webSocketProvider =
        Provider.of<WebSocketAnnouncementProvider>(context);
    return ValueListenableBuilder<Announcement?>(
      valueListenable: webSocketProvider.newAnnouncementNotifier,
      builder: (context, newAnnouncement, child) {
        if (newAnnouncement != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            final announcementProvider =
                Provider.of<AnnouncementProvider>(context, listen: false);

            if (!announcementProvider.listAnnonces
                .any((annonce) => annonce.id == newAnnouncement.id)) {
              announcementProvider.addAnnouncement(newAnnouncement);
              debugPrint(
                  "Nouvelle annonce ajoutée via WebSocket: ${newAnnouncement.description}");
            } else {
              debugPrint("L'annonce existe déjà dans la liste.");
            }
            webSocketProvider.newAnnouncementNotifier.value = null;
          });
        }

        return Consumer<AnnouncementProvider>(
          builder: (context, announcementProvider, child) {
            var listAnnonces = announcementProvider.listAnnonces;

            return Card(
              elevation: 0,
              surfaceTintColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4), // Adjust the radius here
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.01,
                  ),
                  color: const Color(0xFFF7F6FA),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 5,
                      offset: const Offset(-3, 0),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 5,
                      offset: const Offset(3, 0),
                    ),
                  ], // Rounded corners
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Annonces',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(width: 8.0),
                              Image(image: AssetImage(
                                      "assets/images/Announcement.png"))
                            ],
                          ),
                          Text(
                            'Voir tout',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: GlobalColors.nextonbording),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_left),
                              color: GlobalColors.nextonbording,
                              onPressed: _scrollLeft, // Scroll to the left
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * (120/MediaQuery.of(context).size.height),
                              width: MediaQuery.of(context).size.width,
                              child: listAnnonces.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Pas encore d\'annonce pour cette catégorie',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    )
                                  : ListView.builder(
                                      controller:
                                          _scrollControllerAnnonceSection,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listAnnonces.length,
                                      itemBuilder: (context, index) {
                                        var annonce = listAnnonces[index];

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Naviguer vers la page de détail de l'annonce
                                            /*  context.go(
                                                '/announcementHomePage/detail/${annonce.id}',
                                                extra: annonce,
                                              );*/
                                            },
                                            child: ItemAnnonceCard(
                                              //image: annonce.imageUrl!,
                                              titre: annonce.name!,
                                              date: annonce.dateCreation!,
                                              lieu: annonce.location ??
                                                  'Lieu inconnu',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_right),
                              color: GlobalColors.nextonbording,
                              onPressed: _scrollRight, // Scroll to the right
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategoriesSection(
      BuildContext context, TypeEvenementProvider typeEventProvider) {
    var listTypeEvents = typeEventProvider.listTypeEvenements;

    return Card(
      elevation: 0,
      surfaceTintColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Adjust the radius here
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.01,
          ),
          color: const Color(0xFFF7F6FA),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(-3, 0),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(3, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Text(
                    'Evénement à venir',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(width: 8.0),
                  Image(image: AssetImage("assets/images/Calendar.png"))
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * (50/MediaQuery.of(context).size.height),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listTypeEvents.length,
                  itemBuilder: (context, index) {
                    var typeEvenement = listTypeEvents[index];
                    return CategoryButtonAccueil(
                      intitule: typeEvenement.libelle!,
                      isSelected: selectedCategory == typeEvenement.libelle!,
                      onTap: () {
                        setState(() {
                          selectedCategory = typeEvenement.libelle!;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: _buildEventsSection(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventsSection() {
    final webSocketProvider =
        Provider.of<WebSocketGestionInfraProvider>(context);

    return ValueListenableBuilder<Evenement?>(
      valueListenable: webSocketProvider.newEventNotifier,
      builder: (context, newEvent, child) {
        if (newEvent != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            final evenementProvider =
                Provider.of<EvenementProvider>(context, listen: false);

            if (!evenementProvider.listEvents
                .any((event) => event.id == newEvent.id)) {
              evenementProvider.addEvent(newEvent);
              debugPrint(
                  "Nouvel événement ajouté via WebSocket: ${newEvent.nomEvenement}");
            } else {
              debugPrint("L'événement existe déjà dans la liste.");
            }
            webSocketProvider.newEventNotifier.value = null;
          });
        }

        return Consumer<EvenementProvider>(
          builder: (context, evenementProvider, child) {
            var listEvents = evenementProvider.listEvents;

            List<Evenement> filteredEvents = selectedCategory == "Tous"
                ? listEvents
                : listEvents
                    .where((event) =>
                        event.typeEvenement?.libelle == selectedCategory)
                    .toList();

            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (30/MediaQuery.of(context).size.width),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_left),
                    color: GlobalColors.nextonbording,
                    onPressed: _scrollLeftEvent, // Scroll to the left
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * (95/MediaQuery.of(context).size.height),
                width: MediaQuery.of(context).size.width,
                    child: filteredEvents.isEmpty
                        ? const Center(
                            child: Text(
                              'Pas encore d\'événement pour cette catégorie',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollControllerEventSection,
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredEvents.length,
                            itemBuilder: (context, index) {
                              var event = filteredEvents[index];
                              final String eventDate =
                                  event.creneau?.dateDebut != null
                                      ? DateFormat("yyyy-MM-dd")
                                          .format(event.creneau!.dateDebut!)
                                      : 'Date inconnue';
                              final String eventTime =
                                  event.creneau?.dateDebut != null
                                      ? DateFormat("HH:mm")
                                          .format(event.creneau!.dateDebut!)
                                      : 'Heure inconnue';

                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    debugPrint('La route est là =================>');
                                    context.go(
                                      '/eventHomePage/matchDetail/${event.id}?origin=accueil',
                                      extra: event,
                                    );

                                  },
                                  child: ItemEvenementCard(
                                    image: event.creneau!.infrastructure!.fileUrl,
                                    nom: event.nomEvenement ??
                                        'Événement sans nom',
                                    date: eventDate,
                                    heure: eventTime,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (30/MediaQuery.of(context).size.width),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_right),
                    color: GlobalColors.nextonbording,
                    onPressed: _scrollRightEvent, // Scroll to the right
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}



