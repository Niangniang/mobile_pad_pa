import 'package:flutter/material.dart';

import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaymentMethodPage(),
    );
  }
}

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Récapitulatif', style: TypoStyle.textLabelStyleS20W700CBlack,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 30,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(

          children: [
            PaymentOption(
              imagePath: 'assets/images/logo_Wave.png', // Assurez-vous que le chemin est correct
              text: Text('Wave', style: TypoStyle.textLabelStyleS18W600CBlue,),
              onTap: () {
                // Logique pour Wave
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PaymentOption(
                imagePath: 'assets/images/logo_OM.png', // Assurez-vous que le chemin est correct
                text: Text('Orange Money', style: TypoStyle.textLabelStyleS18W600COrange,),
                onTap: () {
                  // Logique pour Orange Money
                },

              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final Text text;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    this.icon,
    this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Widget leadingWidget;
    if (icon != null) {
      leadingWidget = Icon(icon, size: 40);
    } else if (imagePath != null) {
      leadingWidget = Image.asset(imagePath!, width: MediaQuery.of(context).size.width * (30/MediaQuery.of(context).size.width), height: MediaQuery.of(context).size.height * (40/MediaQuery.of(context).size.height));
    } else {
      leadingWidget = Container(); // or some default icon or image
    }

    // Utilisation du widget Card pour ajouter une élévation
    return Card(
      elevation: 3.0,
      color: Colors.white,
      // La valeur de l'élévation peut être ajustée selon les besoins
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),  // Ajouter une marge pour mieux visualiser l'élévation
      child: ListTile(
        leading: leadingWidget,
        title: text,
        trailing: const Icon(Icons.arrow_forward, size: 35, ),
        onTap: onTap,
      ),
    );
  }

}
