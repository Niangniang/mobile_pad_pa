import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_typeEvenement/provider_typeEvenement.dart';
import 'package:provider/provider.dart';
import '../../components/cards/eventCategoryCard.dart';
import '../../components/cards/eventItemCard.dart';
import '../../components/inputs/customCalendar.dart';
import '../../components/searchBarField.dart';
import '../../utils/formatTime.dart';

class EventHomePageScreen extends StatefulWidget {
  const EventHomePageScreen({super.key});

  @override
  State<EventHomePageScreen> createState() => _EventHomePageScreenState();
}

class _EventHomePageScreenState extends State<EventHomePageScreen> {
  bool isLoading = true;
  bool showAllEvents = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    var eventProvider = Provider.of<EvenementProvider>(context, listen: false);
    var typeEvent = Provider.of<TypeEvenementProvider>(context, listen: false);
    await eventProvider.getAllEvenements(context: context);
    await typeEvent.getAllTypeEvenements(context: context);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String selectedCategory = "Tous";

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var typeEventProvider =
        Provider.of<TypeEvenementProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading:  Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Contenu fixe (en-tête)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: SearchBarField(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Row(
                          children: [
                            Text(
                              "Catégorie d'évènement",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              typeEventProvider.listTypeEvenements.length,
                          itemBuilder: (context, index) {
                            var category =
                                typeEventProvider.listTypeEvenements[index];
                            return CategoryEventCard(
                              nom: category.libelle!,
                              isSelected: selectedCategory == category.libelle!,
                              onTap: () {
                                setState(() {
                                  selectedCategory = category.libelle!;
                                  debugPrint(
                                      "SelectedCategorie =====> $selectedCategory");
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Calendrier",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CupertinoColors.lightBackgroundGray,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const CustomCalendar(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 16.0), // Adds spacing between elements
                    ],
                  ),
                ),
                // Contenu défilable (liste des événements)
                Expanded(
                  child: Consumer<EvenementProvider>(
                    builder: (context, eventProvider, _) {
                      var events = eventProvider.listEvents;
                      var filteredEvents = selectedCategory == "Tous"
                          ? events
                          : events
                              .where((event) =>
                                  event.typeEvenement!.libelle ==
                                  selectedCategory)
                              .toList();

                      var displayedEvents = showAllEvents
                          ? filteredEvents
                          : filteredEvents.take(5).toList();

                      return ListView.builder(
                        itemCount: displayedEvents.length,
                        itemBuilder: (context, index) {
                          var event = displayedEvents[index];
                          return GestureDetector(
                              onTap: () {
                                debugPrint(
                                    'Event Json =====> ${event.toJson()}');
                                context.go(
                                  '/eventHomePage/matchDetail/${event.id}?origin=evenement',
                                  extra: event, // Pass the Evenement object as extra
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: ItemEventCard(
                                  title: event.nomEvenement!,
                                  date: DateFormatter.formatDate(
                                      event.creneau!.dateDebut!),
                                  heureDebut: DateFormat('HH:mm')
                                      .format(event.creneau!.dateDebut!),
                                  imagePath:
                                      event.creneau!.infrastructure!.fileUrl!,
                                  id: event.id!,
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
