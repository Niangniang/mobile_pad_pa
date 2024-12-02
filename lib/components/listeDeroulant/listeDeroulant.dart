import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_objetRDV/provider_objetRDV.dart';
import 'package:mobile_pad_pa/providers/provider_rdv/provider_rdv.dart';
import 'package:provider/provider.dart';

import '../../constantes/codeColors/codeColors.dart';

class ListeDeroulant extends StatefulWidget {
  final List<String> listText;
  final String selectItem;
  final TextEditingController controller;
  final Map<String, Infrastructure>
      infrastructureMap; // Add this field to map dropdown items to Infrastructure objects

  ListeDeroulant({
    super.key,
    required this.listText,
    required this.selectItem,
    required this.controller,
    required this.infrastructureMap, // Initialize this in the constructor
  });

  @override
  _ListeDeroulantState createState() => _ListeDeroulantState();
}

class _ListeDeroulantState extends State<ListeDeroulant> {
  Infrastructure?
      selectedInfrastructure; // Store the selected Infrastructure object
  TextEditingController objetRDVController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.selectItem;
  }

  @override
  Widget build(BuildContext context) {
    var objetRDVProvider =
        Provider.of<ObjetRDVProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    objetRDVProvider.getAllObjetRDVs(
        context: context, accessToken: authProvider.authLogin!.access);

    var objetRDVList = objetRDVProvider.listObjetRDVs.toList();

    debugPrint("get lenght objet ${objetRDVList.length}");

    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.infinity, 75)),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownSearch<String>(
                dropdownButtonProps:
                    const DropdownButtonProps(color: GlobalColors.primaryColor),
                popupProps: const PopupProps.menu(showSearchBox: true),
                items: widget.listText,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(
                          color: GlobalColors.nextonbording, width: 1.8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(
                          color: GlobalColors.nextonbording, width: 1.8),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FBFB),
                    labelStyle: const TextStyle(color: Color(0xFF37393c)),
                    hintStyle: const TextStyle(color: Color(0xFF37393c)),
                  ),
                ),
                onChanged: (item) async {
                  if (item != "--- Choisir l'événement à organiser ---") {
                    var select =
                        objetRDVList.firstWhere((e) => "${e.objet}" == item).id;
                    var objetRDVProvider =
                        Provider.of<ObjetRDVProvider>(context, listen: false);
                    objetRDVProvider.setSingleObjetRDVById(select!);
                    rdvProvider.setObjetRDVItem(item!);
                    debugPrint(
                        "get objetID de  RDV  ${objetRDVProvider.objetRDVId}");
                    debugPrint("get objet RDV $item");
                  }

                  setState(() {
                    objetRDVController.text = item!;
                  });
                  debugPrint("Selected item: $item");
                },
                selectedItem: objetRDVController.text.isEmpty
                    ? "--- Choisir l'événement à organiser ---"
                    : objetRDVController.text,
              ),
            ],
          );
        },
      ),
    );
  }
}
