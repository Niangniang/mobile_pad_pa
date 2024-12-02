import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import '../../components/cards/eventListCard.dart';
import '../../components/cards/infoCard.dart';
import '../../constantes/codeColors/codeColors.dart';
import '../../constantes/textStyles/textStyle.dart';

class InformationScreen extends StatefulWidget {
  final Infrastructure infrastructure;
  const InformationScreen({super.key, required this.infrastructure});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {

  @override
  Widget build(BuildContext context) {


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
              context.goNamed("accueil");
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Stade ${widget.infrastructure.nom}',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
            ],
          ),
        ),
        elevation: 30,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Information ${widget.infrastructure.typeInfrastructure!.libelle}  ${widget.infrastructure.nom}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InfoCard(infra: widget.infrastructure),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Evénements liés au stade",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  EventList(infrastructure: widget.infrastructure),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          // Positioned widget to float the button
          Positioned(
            right: 16.0, // Distance from the right edge
            top: MediaQuery.of(context).size.height / 3.6, // Middle of the screen
            child: TextButton(
              onPressed: () {
                context.goNamed('accueilReservation', extra: widget.infrastructure);
              },
              child: Container(
                width: 85.0,
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: GlobalColors.nextonbording,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: GlobalColors.nextonbording,
                  ),
                ),
                child: const Text(
                  "Réserver",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
