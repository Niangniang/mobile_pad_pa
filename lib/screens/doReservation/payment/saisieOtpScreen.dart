import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/components/inputs/phoneTextField.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_creneau/provider_creneauEvent.dart';
import 'package:mobile_pad_pa/providers/provider_evenement/provider_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_infrastructure/provider_infrastruture.dart';
import 'package:mobile_pad_pa/providers/provider_paiement/provider_paiement.dart';
import 'package:mobile_pad_pa/providers/provider_typeEvenement/provider_typeEvenement.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

void showDialogSuccess(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Padding(
          padding: EdgeInsets.only(left: 25, right: 16),
          child: Text(
            'Paiement réussi',
            style: TypoStyle.textLabelStyleS22W600CBlack,
          ),
        ),
        content: SizedBox(
          height: 180,
          child: Column(
            children: [
              Image.asset('assets/images/icon_success.png'),
              const SizedBox(height: 20),
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
                              horizontal: 20, vertical: 0),
                        ),
                      ),
                      child: const Text(
                        'ici',
                        style: TypoStyle.textLabelStyleS22W600CGreen1,
                      ),
                    ),
                    Text('pour afficher',
                        style: TypoStyle.textLabelStyleS14W600CBlack),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text('votre reçu', style: TypoStyle.textLabelStyleS14W600CBlack),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.goNamed("reservation_history");
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('OK', style: TypoStyle.textLabelStyleS22W600CGreen1),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  AuthProvider? authProvider;
  EvenementProvider? evenementProvider;
  PaiementProvider? paiementProvider;
  InfrastructureProvider? infrastructureProvider;
  TypeEvenementProvider? typeEvenementProvider;
  CreneauEventProvider? creneauEventProvider;

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    paiementProvider = Provider.of<PaiementProvider>(context, listen: false);
    infrastructureProvider =
        Provider.of<InfrastructureProvider>(context, listen: false);
    typeEvenementProvider =
        Provider.of<TypeEvenementProvider>(context, listen: false);
    creneauEventProvider =
        Provider.of<CreneauEventProvider>(context, listen: false);
  }

  Future<void> _submitEvenement() async {
    if (authProvider == null ||
        evenementProvider == null ||
        paiementProvider == null ||
        infrastructureProvider == null ||
        typeEvenementProvider == null ||
        evenementProvider == null) {
      debugPrint("One of the providers is null");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic> dataPaiement = {
        "numero_client": _phoneController.text,
        "otp": _otpController.text,
        "date_debut": creneauEventProvider?.dateDebut,
        "date_fin": creneauEventProvider?.dateFIn,
        "access_token": authProvider!.authLogin?.access
      };

      debugPrint('=========================> Data send $dataPaiement');

      await paiementProvider!.addPaiement(
          data: dataPaiement,
          context: context,
          id: typeEvenementProvider!.typeEvenementId);

      var paiementId = paiementProvider!.newPaiement?['paiement']['id'];
      debugPrint('=========================> ID P $paiementId');
      debugPrint(
          '=========================> date debut cre ${creneauEventProvider?.dateDebut}');
      debugPrint(
          '=========================> date fin cre ${creneauEventProvider?.dateFIn}');

      if (paiementId == null) {
        debugPrint("Paiement ID is null");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      Map<String, dynamic> dataEvenement = {
        "description": evenementProvider!.description,
        "nomEvenement": evenementProvider!.nomEvent,
        "typeEvenement": {"id": typeEvenementProvider!.typeEvenementId},
        "utilisateur": authProvider!.authLogin?.user.id,
        "creneau": {
          "estDisponible": false,
          "dateDebut": creneauEventProvider?.dateDebut,
          "dateFin": creneauEventProvider?.dateFIn,
          "infrastructure": {"id": infrastructureProvider!.infraId}
        },
        "paiement": {"id": paiementId},
        "estRecurrent": false
      };
      debugPrint('=====================Send Data $dataEvenement');

      await evenementProvider!
          .addEvenement(evenement: dataEvenement, context: context);

      setState(() {
        _isLoading = false;
      });

      context.goNamed('reservation_history');
      showDialogSuccess(context);
    } catch (error) {
      debugPrint("Erreur lors de l'ajout du paiement ou evenement: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Code OTP',
          style: TypoStyle.textLabelStyleS20W700CBlack,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Text('Saisir le numéro Orange Money',
                style: TypoStyle.textLabelStyleS16W600CBlack),
            PhoneTextField(
              label: "",
              hintText: "Numéro Orange Money",
              controller: _phoneController,
            ),
            const SizedBox(height: 16),
            Text('Renseignez le code OTP',
                style: TypoStyle.textLabelStyleS16W600CBlack),
            const SizedBox(height: 24),
            Pinput(
              length: 6,
              controller: _otpController,
              focusNode: FocusNode(),
              onCompleted: (pin) {
                debugPrint('Le PIN saisi est : $pin');
                _otpController.text = pin;
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
              defaultPinTheme: PinTheme(
                width: 56,
                height: 65,
                textStyle: const TextStyle(fontSize: 20, color: Colors.green),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 58,
                height: 58,
                textStyle: const TextStyle(fontSize: 22, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              submittedPinTheme: PinTheme(
                width: 56,
                height: 65,
                textStyle: const TextStyle(fontSize: 35, color: Colors.green),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              errorPinTheme: PinTheme(
                width: 56,
                height: 65,
                textStyle: const TextStyle(fontSize: 20, color: Colors.red),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tapez', style: TypoStyle.textLabelStyleS16W600CBlack),
                Text(' #144#391*code secret#',
                    style: TypoStyle.textLabelStyleS14W600CRed),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.nextonbording,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading
                    ? null
                    : _submitEvenement, // Désactiver le bouton pendant le chargement
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            GlobalColors.nextonbording),
                      )
                    : Text(
                        'Valider',
                        style: TypoStyle.textLabelStyleS20W600CWhite,
                      ),
              ),
            ),
            /*SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.nextonbording,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitEvenement,
                child: Text(
                  'Valider',
                  style: TypoStyle.textLabelStyleS20W600CWhite,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
