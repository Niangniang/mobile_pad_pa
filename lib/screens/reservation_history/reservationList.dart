import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/cards/reservationItem.dart';
import '../../providers/provider_authentification/provider_authentification.dart';
import '../../providers/provider_evenement/provider_evenement.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({super.key});

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
 // late Future<void> _loadEvenements;
  bool _isLoading = false;
  AuthProvider? authProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          loadData();

        });
      }
    });
  }

  void loadData() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<EvenementProvider>(context, listen: false)
        .getAllEvenementsByUser(
        context: context,
        accessToken: authProvider!.authLogin!.access,
        id: authProvider?.authLogin?.user.id ?? '');

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<EvenementProvider>(
      builder: (context, evenementProvider, child) {
        var listEvenements = evenementProvider.listEventsByUser;

        if (listEvenements.isEmpty) {
          return const Center(
              child: Text('Aucun événement disponible pour l\'utilisateur.'));
        }

        return ListView.builder(
          itemCount: listEvenements.length,
          itemBuilder: (context, index) {
            final evenement = listEvenements[index];
            return GestureDetector(
              onTap: () {
                context.goNamed('reservation_detail',
                    pathParameters: {'id': evenement.id.toString()});
              },
              child: Padding(

                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ReservationItem(
                  title: evenement.nomEvenement ?? 'N/A',
                  date: DateFormat('EEEE \'le\' d MMM yyyy', 'fr_FR')
                      .format(evenement.creneau!.dateDebut!),
                  heure:
                  "${DateFormat('HH \'H\' mm').format(evenement.creneau!.dateDebut!)} à ${DateFormat('HH \'H\' mm').format(evenement.creneau!.dateFin!)}",
                  localite: evenement.typeEvenement?.libelle ?? 'N/A',
                  img: evenement.creneau!.infrastructure!.fileUrl!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

