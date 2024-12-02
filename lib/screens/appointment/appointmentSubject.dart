import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_objetRDV/provider_objetRDV.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';

import 'package:provider/provider.dart';
import '../../components/button/eventCustomButton.dart';
import '../../components/inputs/descriptionTextField.dart';
import '../../components/listeDeroulant/listeDeroulant.dart';
import '../../constantes/codeColors/codeColors.dart';

class AppointmentSubjectScreen extends StatefulWidget {
  const AppointmentSubjectScreen({super.key});

  @override
  State<AppointmentSubjectScreen> createState() =>
      _AppointmentSubjectScreenState();
}

class _AppointmentSubjectScreenState extends State<AppointmentSubjectScreen> {


  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });

  }

  void loadData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var objetRDVProvider = Provider.of<ObjetRDVProvider>(context, listen: false);
    await objetRDVProvider.getAllObjetRDVs(context: context, accessToken: authProvider.authLogin!.access );
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }


  final _subjectFormKey = GlobalKey<FormState>();
  TextEditingController listController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    if (!_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    var objetRDVProvider = Provider.of<ObjetRDVProvider>(context,listen: false);
    var objetRDVsList = objetRDVProvider.listObjetRDVs.toList();
    var rdvProvider = Provider.of<RDVProvider>(context,listen: false);

    List<String> sujet = [
      "--- Choisir l'objet de votre RDV ---",
      ...objetRDVsList.map((e) => "${e.objet}").toList(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 8.0), // Ajoutez du padding à gauche du CircleAvatar
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
          padding: EdgeInsets.symmetric(
              horizontal:
                  0.5), // Ajoute du padding à gauche et à droite du titre
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Pour aligner le texte à gauche
            mainAxisSize:
                MainAxisSize.min, // Pour empêcher la colonne de s'étendre
            children: [
              Text(
                'Prendre un rendez-vous',
                style: TypoStyle.textLabelStyleS18W600CBlack1,
              ),
            ],
          ),
        ),
        elevation: 30,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Form(
            key: _subjectFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "De quoi souhaitez vous discuter ?",
                  style: TypoStyle.textLabelStyleS18W600CBlack1,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Objet du rendez-vous",
                  style: TypoStyle.textLabelStyleS16W500CBlack1,
                ),
                const SizedBox(height: 8.0),
                ListeDeroulant(
                  listText: sujet,
                  selectItem: "Demande de financement",
                  controller: listController,
                  infrastructureMap: {},
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Description",
                  style: TypoStyle.textLabelStyleS16W500CBlack1,
                ),
                const SizedBox(height: 8.0),
                DescriptionTextField(
                  hintText: "Description",
                  controller: descriptionController,
                ),
                const SizedBox(height: 64.0),
                EventCustomButton(
                  text: "Suivant",
                  onTap: () {

                    rdvProvider.setDescription(descriptionController.text);

                    if (_subjectFormKey.currentState!.validate()) {
                      context.goNamed("discussionChoice");
                      /*authUser.registreUser(
                                    user: data, context: context);*/
                    }
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
