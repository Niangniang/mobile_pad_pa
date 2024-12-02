import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';


class PaymentModPage extends StatefulWidget {
  const PaymentModPage({super.key});

  @override
  State<PaymentModPage> createState() => _PaymentModPageState();
}



class _PaymentModPageState extends State<PaymentModPage> {

  bool _providerInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_providerInitialized) {
        _providerInitialized = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {








    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Récapitulatif',
          style: TypoStyle.textLabelStyleS20W700CBlack,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                "Choisir un mode de paiement",
                style: TypoStyle.textLabelStyleS16W500CBlack,
              ),
            ),
            PaymentOption(
              imagePath: 'assets/images/logo_Wave.png',
              text: const Text(
                'Wave',
                style: TypoStyle.textLabelStyleS18W600CBlue,
              ),
              onTap: () {
                context.goNamed("wavePayment");
              },
            ),
            const SizedBox(height: 20.0),
            PaymentOption(
              imagePath: 'assets/images/logo_OM.png',
              text: const Text(
                'Orange Money',
                style: TypoStyle.textLabelStyleS18W600COrange,
              ),
              onTap: () {
                context.goNamed("saisieOTP");
              },
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
      leadingWidget = Image.asset(
        imagePath!,
        width: 50,
        height: 40,
      );
    } else {
      leadingWidget = Container(); // or some default icon or image
    }

    // Utilisation du widget Card pour ajouter une élévation
    return Card(
      elevation: 3.0,
      color: Colors.white,
      // La valeur de l'élévation peut être ajustée selon les besoins
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0), // Ajouter une marge pour mieux visualiser l'élévation
      child: ListTile(
        leading: leadingWidget,
        title: text,
        trailing: const Icon(
          Icons.arrow_forward,
          size: 35,
        ),
        onTap: onTap,
      ),
    );
  }
}
