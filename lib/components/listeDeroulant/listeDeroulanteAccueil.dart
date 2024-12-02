import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../constantes/codeColors/codeColors.dart';

class ListeDeroulanteAccueil extends StatefulWidget {
  final List<String> listText;
  final String selectItem;
  final TextEditingController controller;
  final void Function(String?) onChanged; // Update this to accept a function

  ListeDeroulanteAccueil({
    super.key,
    required this.listText,
    required this.selectItem,
    required this.controller,
    required this.onChanged, // Initialize this in the constructor
  });

  @override
  _ListeDeroulanteAccueilState createState() => _ListeDeroulanteAccueilState();
}

class _ListeDeroulanteAccueilState extends State<ListeDeroulanteAccueil> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.selectItem;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.infinity, 60)),
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
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(
                          color: GlobalColors.nextonbording, width: 1.8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                          color: GlobalColors.nextonbording, width: 1.8),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FBFB),
                    labelStyle: const TextStyle(color: Color(0xFF37393c)),
                    hintStyle: const TextStyle(color: Color(0xFF37393c)),
                  ),
                ),
                onChanged: (item) {
                  widget.controller.text = item ?? "";
                  widget.onChanged(
                      item); // Notify the parent widget of the change
                },
                selectedItem: widget.controller.text.isEmpty
                    ? "--- Choisir l'événement à organiser ---"
                    : widget.controller.text,
              ),
            ],
          );
        },
      ),
    );
  }
}
