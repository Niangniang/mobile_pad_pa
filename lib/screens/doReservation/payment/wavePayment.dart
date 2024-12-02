import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import '../../../components/button/customButton.dart';
import '../../../components/inputs/amountTextField.dart';
import '../../../components/inputs/myTextField.dart';
import '../../../components/inputs/phoneTextField.dart';
import '../../../constantes/codeColors/codeColors.dart';

class WavePaymentScreen extends StatefulWidget {
  const WavePaymentScreen({super.key});

  @override
  State<WavePaymentScreen> createState() => _WavePaymentScreenState();
}

class _WavePaymentScreenState extends State<WavePaymentScreen> {
  void showDialogSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Padding(
              padding: EdgeInsets.only(left: 25, right: 16),
              child: Text(
                'Paiément réussi',
                style: TypoStyle.textLabelStyleS22W600CBlack,
              ),
            ),
            content: SizedBox(
              height: 180,
              child: Column(
                children: [
                  Image.asset('assets/images/icon_success.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text('Cliquez',
                            style: TypoStyle.textLabelStyleS14W600CBlack),
                        TextButton(
                            onPressed: () {
                              context.goNamed("recuView");
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical:
                                          0)), // Augmente le padding horizontal
                            ),
                            child: const Text(
                              'ici',
                              style: TypoStyle.textLabelStyleS22W600CGreen1,
                            )),
                        Text('pour afficher  ',
                            style: TypoStyle.textLabelStyleS14W600CBlack),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  (Text('votre reçu',
                      style: TypoStyle.textLabelStyleS14W600CBlack))
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  context.goNamed("doReservation");
                  Navigator.pop(context);
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OK',
                      style: TypoStyle.textLabelStyleS22W600CGreen1,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  final _reservationFormKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController montantController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Réserver mon billet",
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
          child: Form(
            key: _reservationFormKey,
            child: Column(
              children: [
                PhoneTextField(
                  label: "",
                  hintText: "Numéro de téléphone",
                  controller: phoneController,
                ),
                AmountTextField(
                  label: "",
                  hintText: "Montant",
                  controller: montantController,
                ),
                const SizedBox(height: 16.0),
                CustomButton(
                  text: "Payer",
                  onTap: () {
                    // Vous pouvez ajouter votre logique de paiement ici
                    debugPrint("Nom: ${nomController.text}");
                    debugPrint("Téléphone: ${phoneController.text}");
                    debugPrint("Montant: ${montantController.text}");

                    debugPrint("Bouton Payer ======>");
                    showDialogSuccess(context);
                    /*if (_userRegisterFormKey.currentState!
                                  .validate()) {
                                authUser.registreUser(
                                    user: data, context: context);
                              }*/
                  },
                  btnSize: const Size(double.infinity, 44),
                  colorbtn: GlobalColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
