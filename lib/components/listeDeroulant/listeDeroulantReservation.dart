import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';

import '../../constantes/codeColors/codeColors.dart';
import '../../screens/ReservationScreen.dart';

class ListeDeroulantReservation extends StatefulWidget {
  final List<String> listText;
  final String selectItem;
  final TextEditingController controller;
  final Map<String, Infrastructure> infrastructureMap;
  final Function(String) onButtonClick;

  ListeDeroulantReservation({
    super.key,
    required this.listText,
    required this.selectItem,
    required this.controller,
    required this.infrastructureMap,
    required this.onButtonClick,
  });

  @override
  _ListeDeroulantReservationState createState() =>
      _ListeDeroulantReservationState();
}

class _ListeDeroulantReservationState extends State<ListeDeroulantReservation> {
  Infrastructure? selectedInfrastructure;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.selectItem;
    selectedInfrastructure = widget.infrastructureMap[widget.selectItem];
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.infinity, 70)),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return Column(
            children: [
              DropdownSearch<String>(
                  dropdownButtonProps: const DropdownButtonProps(
                    color: GlobalColors.primaryColor,
                  ),
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search), // Search icon
                        hintText: "Rechercher...",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  ),
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
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FBFB),
                      labelStyle: const TextStyle(color: Color(0xFF37393c)),
                      hintStyle: const TextStyle(color: Color(0xFF37393c)),
                    ),
                  ),
                  onChanged: (item) {
                    setState(() {
                      selectedInfrastructure = widget.infrastructureMap[item];
                      widget.controller.text = item!;
                    });
                    if (selectedInfrastructure != null) {
                      widget.onButtonClick(item!);
                    }
                  },
                  selectedItem: widget.controller.text.isEmpty
                      ? "--- Sélectionner une infrastructure ---"
                      : "--- Sélectionner une infrastructure ---" //widget.controller.text,
                  ),
              if (selectedInfrastructure != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyButton(
                    label: selectedInfrastructure!.nom ?? 'Default Name',
                    infrastructure: selectedInfrastructure!,
                    isActive: false,
                    onPressed: (Infrastructure infra) {
                      widget.onButtonClick(infra.nom!);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Infrastructure infrastructure;
  final String label;
  final bool isActive;
  final Function(Infrastructure) onPressed;

  const MyButton({
    super.key,
    required this.infrastructure,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: ElevatedButton(
        onPressed: () => onPressed(infrastructure),
        child: Text(label),
      ),
    );
  }
}
