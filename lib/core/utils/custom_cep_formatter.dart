
import 'package:flutter/services.dart';

class CustomCepFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if(text.length > 8) return oldValue;


    String formatted = text;

    if(text.length > 5) {
      formatted = '${text.substring(0, 5)}-${text.substring(5)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length)
    );

  }


}