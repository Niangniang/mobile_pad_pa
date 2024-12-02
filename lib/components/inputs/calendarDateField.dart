import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constantes/codeColors/codeColors.dart';

class MyDatePickerTextField extends StatefulWidget {
  const MyDatePickerTextField({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
    required this.controller,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateChanged;
  final TextEditingController controller;

  @override
  _MyDatePickerTextFieldState createState() => _MyDatePickerTextFieldState();
}

class _MyDatePickerTextFieldState extends State<MyDatePickerTextField> {
  DateTime? _selectedDate;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _controller.text = _formatDate(_selectedDate!);
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est obligatoire';
    }
    return null;
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: widget.firstDate ?? DateTime.utc(1970),
      lastDate: widget.lastDate ?? DateTime.utc(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(_selectedDate!);
      });
      widget.onDateChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 60)),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: GlobalColors.nextonbording,
                  width: 1.8,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF9FBFB),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              hintStyle: const TextStyle(
                color: Color(0xFF37393c),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              enableSuggestions: false,
              controller: _controller,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              validator: (value) => _validate(value),
            ),
          ),
        ),
      ],
    );
  }
}
