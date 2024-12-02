import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import '../../components/cards/concertDetailCard.dart';
import '../../constantes/codeColors/codeColors.dart';

class ConcertDetailScreen extends StatefulWidget {
  const ConcertDetailScreen({super.key});

  @override
  State<ConcertDetailScreen> createState() => _ConcertDetailScreenState();
}

class _ConcertDetailScreenState extends State<ConcertDetailScreen> {
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
            onPressed: () {},
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Détail de l'événement",
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
            SizedBox(
              height: 700,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 230,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/concert.png',
                        ),
                      ),
                    ),
                  )),
                  const Positioned(
                    width: 390,
                    height: 510,
                    top: 180,
                    child: ConcertDetailCard(),
                  ),
                ],
              ),
            ),
            Text(
              "Réservez sur l'appli ou au",
              style: TypoStyle.textLabelStyleS18W700CBlack,
            ),
            const SizedBox(height: 4.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call_outlined,
                  color: GlobalColors.nextonbording,
                  size: 20,
                ),
                SizedBox(width: 4.0),
                Text(
                  "+221 33 800 00 00 / +221 77 800 00 00",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 98.0),
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
                  context.goNamed("ticketReservation");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Réserver un ticket",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
