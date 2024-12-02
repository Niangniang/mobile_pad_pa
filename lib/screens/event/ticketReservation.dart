import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import '../../components/button/customButton.dart';
import '../../components/inputs/myTextField.dart';
import '../../components/inputs/phoneTextField.dart';
import '../../constantes/codeColors/codeColors.dart';

class TicketReservationScreen extends StatefulWidget {
  const TicketReservationScreen({super.key});

  @override
  State<TicketReservationScreen> createState() =>
      _TicketReservationScreenState();
}

class _TicketReservationScreenState extends State<TicketReservationScreen> {
  void _showSuccessPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Paiement Réussi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(
                'assets/images/icon_success.png',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cliquez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed("ticketView");
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Ici",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.nextonbording),
                    ),
                  ),
                  const Text(
                    "pour afficher ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Text(
                "votre ticket. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final _reservationFormKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  bool _isPaymentSelected = false;
  String _selectedPaymentMethod = "";
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    nomController.addListener(_checkFormValid);
    phoneController.addListener(_checkFormValid);
    montantController.addListener(_checkFormValid);
  }

  void _checkFormValid() {
    setState(() {
      _isFormValid = nomController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          montantController.text.isNotEmpty &&
          _isPaymentSelected;
    });
  }

  void _onPaymentMethodSelected(String method) {
    setState(() {
      _isPaymentSelected = true;
      _selectedPaymentMethod = method;
    });
    _checkFormValid();
    debugPrint("** Paiement par $method **");
  }

  @override
  void dispose() {
    nomController.removeListener(_checkFormValid);
    phoneController.removeListener(_checkFormValid);
    montantController.removeListener(_checkFormValid);
    nomController.dispose();
    phoneController.dispose();
    montantController.dispose();
    super.dispose();
  }

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
                MyTextField(
                  label: "",
                  hintText: "Renseigner votre nom",
                  controller: nomController,
                ),
                PhoneTextField(
                  label: "",
                  hintText: "Numéro de téléphone",
                  controller: phoneController,
                ),
                const SizedBox(height: 16.0),
                if (!_isPaymentSelected) _buildPaymentOptions(),
                if (_isPaymentSelected) _buildPaymentInput(),
                const SizedBox(height: 16.0),
                if (_isFormValid)
                  CustomButton(
                    text: "Payer",
                    onTap: () {
                      // Vous pouvez ajouter votre logique de paiement ici
                      debugPrint("Nom: ${nomController.text}");
                      debugPrint("Téléphone: ${phoneController.text}");
                      debugPrint("Montant: ${montantController.text}");
                      debugPrint("Paiement par: $_selectedPaymentMethod");

                      debugPrint("Bouton Payer ======>");
                      _showSuccessPaymentDialog(context);
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

  Widget _buildPaymentOptions() {
    return Row(
      children: [
        const Text(
          "Payer par :",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(width: 16.0),
        SizedBox(
          width: 50,
          height: 50,
          child: InkWell(
            onTap: () => _onPaymentMethodSelected("Wave"),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: -1,
                    blurRadius: 5,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/logo_Wave.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        SizedBox(
          width: 50,
          height: 50,
          child: InkWell(
            onTap: () => _onPaymentMethodSelected("Orange Money"),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: -1,
                    blurRadius: 5,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/logo_OM.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text("Paiement par $_selectedPaymentMethod",
              style: TypoStyle.textLabelStyleS16W500CNextonbording),
          const SizedBox(height: 16.0),
          TextField(
            controller: montantController,
            keyboardType: TextInputType.number,
            maxLength: 28,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              /*FilteringTextInputFormatter.deny(
                  RegExp(r'[0-9]')),*/ // Empêche les chiffres
              FilteringTextInputFormatter.deny(RegExp(
                  r'[^\x00-\x7F]+')), // Empêche les caractères non ASCII (comme les emojis)
            ],
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              border: UnderlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.8,
                ),
              ),
              filled: true,
              fillColor: Color(0xFFF9FBFB),
              labelStyle: TextStyle(
                color: GlobalColors.nextonbording,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              hintStyle: TextStyle(
                color: Color(0xFF37393c),
              ),
              hintText: 'Entrez le montant',
            ),
            onSubmitted: (value) {
              debugPrint("Montant entré: $value");
              // Vous pouvez ajouter une logique pour traiter le montant entré ici
            },
          ),
        ],
      ),
    );
  }
}
