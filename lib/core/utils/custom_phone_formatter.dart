import 'package:flutter/services.dart';

class CustomPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    
    final isDeleting = oldValue.text.length > newValue.text.length;


    final oldNumbers = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String newNumbers = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');


    if (isDeleting && oldNumbers.length == newNumbers.length && newNumbers.isNotEmpty) {
      newNumbers = newNumbers.substring(0, newNumbers.length - 1);
    }

    if (newNumbers.length > 11) {
      newNumbers = newNumbers.substring(0, 11);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < newNumbers.length; i++) {
      if (i == 0) buffer.write('(');
      buffer.write(newNumbers[i]);
      if (i == 1) buffer.write(') ');
      if (i == 6) buffer.write('-');
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}