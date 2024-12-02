import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length == 2 || newValue.text.length == 5) {
      return TextEditingValue(
        text: '${newValue.text}/',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    }
    return newValue;
  }
}

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length == 2) {
      return TextEditingValue(
        text: '${newValue.text}:',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    }
    return newValue;
  }
}
