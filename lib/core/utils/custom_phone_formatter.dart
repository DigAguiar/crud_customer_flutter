

import 'package:flutter/services.dart';

class CustomPhoneFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if(text.length > 11) return oldValue;

    final buffer = StringBuffer();
    for(int i = 0; i < text.length; i++) {
      if(i == 0) buffer.write('(');

      buffer.write(text[i]);

      if(i == 1) buffer.write(') ');
      if(i == 6) buffer.write(' ');

    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length)
    );

  }

}