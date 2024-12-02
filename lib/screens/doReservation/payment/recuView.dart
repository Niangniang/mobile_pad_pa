import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';

import '../../../constantes/codeColors/codeColors.dart';

class RecuViewScreen extends StatefulWidget {
  const RecuViewScreen({super.key});

  @override
  State<RecuViewScreen> createState() => _RecuViewScreenState();
}

class _RecuViewScreenState extends State<RecuViewScreen> {
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
              context.pop();
            },
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ticket d'entrer",
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
            ],
          ),
        ),
        elevation: 30,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/recu.png",
                  fit: BoxFit.cover,
                  width: 350,
                  height: 170,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: GlobalColors.nextonbording,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    "Télécharger",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
