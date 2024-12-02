import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:provider/provider.dart';
import '../../constantes/codeColors/codeColors.dart';
import 'newEventCard.dart';

class EventList extends StatefulWidget {

  final Infrastructure infrastructure;
  const EventList({super.key, required this.infrastructure});


  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  bool showAllEvents = false;
  bool _isLoading = true;

void loadData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var eventProvider = Provider.of<EvenementProvider>(context, listen: false);
    await eventProvider.getAllEvenementsByInfra(
        context: context, id: widget.infrastructure.id!, accessToken: authProvider.authLogin!.access);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementProvider>(
      builder: (context, eventProvider, child) {
        var listEvents = eventProvider.listEvents;
        final displayedEvents = showAllEvents ? listEvents : listEvents.take(3).toList();
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          height: 280,
          child: Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: displayedEvents.length,
                itemBuilder: (context, index) {
                  final event = displayedEvents[index];
                  return NewEventCard(
                    title: event.nomEvenement!,
                    date: DateFormat("yyyy-MM-dd").format(event.creneau!.dateDebut!),
                    time: DateFormat("HH:mm").format(event.creneau!.dateDebut!),
                    imageUrl: "${event.fileUrl}",
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAllEvents = !showAllEvents;
                    });
                  },
                  child: Text(
                    showAllEvents ? "Voir moins" : "Voir tout",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GlobalColors.nextonbording,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
