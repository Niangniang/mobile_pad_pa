import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';



void showDialogOTP(BuildContext context){
  showDialog(context: context, builder: (context){
    return  AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(left: 25, right: 16),
        child: Text('Paiément réussi', style: TypoStyle.textLabelStyleS22W600CBlack,),
      ),
      content:  SizedBox(
        height: 180,

        child: Column(
          children: [
            Image.asset('assets/images/icon_success.png'),

            const SizedBox(height: 20,),

             Expanded(
               child: Row(
                 children: [
                Text('Cliquez', style: TypoStyle.textLabelStyleS14W600CBlack), TextButton(onPressed: (){},  style: ButtonStyle(
                     padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 0)), // Augmente le padding horizontal
                   ), child: const Text('ici', style: TypoStyle.textLabelStyleS22W600CGreen1,)), Text('pour afficher  ', style: TypoStyle.textLabelStyleS14W600CBlack),
                 ],
               ),
             ),
            const SizedBox(height: 6,),
            (Text('votre reçu', style: TypoStyle.textLabelStyleS14W600CBlack))
          ],

        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){ return Navigator.pop(context);}, child: const Text('OK', style: TypoStyle.textLabelStyleS22W600CGreen1,),)

      ],


    );
  });

  }







class PinInputPage extends StatelessWidget {
  const PinInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Code OTP', style: TypoStyle.textLabelStyleS20W700CBlack,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 30,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:20, left: 16, right: 16, ),
          child: Column(
            children: [
              const Text('Entrez votre Code', style: TypoStyle.textLabelStyleS22W600CBlack,),
              const SizedBox(height: 50,),
              Pinput(
                length: 6, // Définit le nombre de champs de PIN (généralement 4 ou 6)
                controller: TextEditingController(),
                focusNode: FocusNode(),
                onCompleted: (pin) {
                  // Ici, vous pourriez vouloir faire quelque chose avec le pin, comme une vérification
                  debugPrint('Le PIN saisi est : $pin');
                },
                onChanged: (pin) {
                  debugPrint('Le PIN changé : $pin');
                },
                validator: (pin) {
                  if (pin == null || pin.length < 4) {
                    return 'Entrez un PIN valide.';
                  }
                  return null;
                },
                pinAnimationType: PinAnimationType.fade,

                // Ajoute une animation de fondu pour les champs de PIN
                // Définir les thèmes pour différents états
                defaultPinTheme: PinTheme(
                  width: MediaQuery.of(context).size.width * (56/MediaQuery.of(context).size.width),
                  height: MediaQuery.of(context).size.height * (65/MediaQuery.of(context).size.height),
                  textStyle: const TextStyle(fontSize: 20, color: Colors.green),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: MediaQuery.of(context).size.width * (58/MediaQuery.of(context).size.width),
                  height: MediaQuery.of(context).size.height * (58/MediaQuery.of(context).size.height),
                  textStyle: const TextStyle(fontSize: 22, color: Colors.black),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: MediaQuery.of(context).size.width * (56/MediaQuery.of(context).size.width),
                  height: MediaQuery.of(context).size.height * (65/MediaQuery.of(context).size.height),
                  textStyle: const TextStyle(fontSize: 35, color: Colors.green),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 56,
                  height: 65,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.red),
                  decoration: BoxDecoration(
                    //color: Colors.red.shade50,
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hapticFeedbackType: HapticFeedbackType.lightImpact, // Réaction tactile légère à chaque frappe
              ),

              const SizedBox(height: 100,),

              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * (56/MediaQuery.of(context).size.height), // Hauteur du button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.nextonbording, // Utilisez votre couleur personnalisée
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Un peu arrondi pour l'esthétique
                    ),
                  ),

                  onPressed: () {

                    showDialogOTP(context);

                  },
                  child: Text('Velider',style: TypoStyle.textLabelStyleS20W600CWhite,),

                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
