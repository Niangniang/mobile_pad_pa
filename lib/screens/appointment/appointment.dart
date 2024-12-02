import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
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
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);

    // Appel de l'API pour charger les rendez-vous
    await rdvProvider.getAllRDVsByUser(
      context: context,
      accessToken: authProvider.authLogin!.access,
      id: authProvider.authLogin!.user.id!,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:  SizedBox(
            height: MediaQuery.of(context).size.height * (45/MediaQuery.of(context).size.height),  // Hauteur de l'image
            width: MediaQuery.of(context).size.width * (45/MediaQuery.of(context).size.width),   // Largeur de l'image (égale à la hauteur pour un cercle)
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),  // Rayon de moitié pour rendre l'image circulaire
              child: CachedNetworkImage(
                imageUrl: '${authProvider.authLogin!.user.attachement}',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const SizedBox(),
                fit: BoxFit.cover,
              ),
            ),
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
                "${authProvider.authLogin?.user.prenom} ${authProvider.authLogin?.user.nom}",
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
      body: Stack(
        children: [
          Padding(
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
                Row(
                  children: [
                    Expanded(
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
                        onPressed: () {
                          context.pushNamed("appointment");
                        },
                        child: const Text(
                          "Mes rendez-vous",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),  // Ajouter un espacement entre les boutons
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
                        context.goNamed("pastAppointment");
                      },
                      child: const Text(
                        "rendez-vous passés",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Consumer<RDVProvider>(
                    builder: (context, provider, child) {
                      if (provider.listRDVsByUser.isEmpty) {
                        return const Center(
                            child: Text("Aucun rendez-vous trouvé."));
                      }

                      return ListView.builder(
                        itemCount: provider.listRDVsByUser.length,
                        itemBuilder: (context, index) {
                          final appointment = provider.listRDVsByUser[index];

                          // Vérification de nullité pour fileUrl
                          final imageUrl = appointment.creneau?.personneDemande?.fileUrl;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.lightBackgroundGray,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child: imageUrl != null && imageUrl.isNotEmpty
                                    ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const SizedBox(),
                                  fit: BoxFit.cover,
                                )
                                    : const SizedBox(),
                              ),
                              title: Text(
                                appointment.objetRDV?.objet ?? 'Objet non défini',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointment.typeRdv ?? 'Type non défini',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(appointment.date!),
                                        style: const TextStyle(color: Colors.green),
                                      ),
                                      Text(
                                        DateFormat('HH:mm', 'fr_FR')
                                            .format(appointment.creneau?.debut ?? DateTime.now()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                context.goNamed('detailsApointement',  extra: appointment,);
                              },
                            ),
                          );
                        },
                      );

                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
