

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomerFormField extends StatelessWidget{
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final bool readOnly;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CustomerFormField({
    required this.label,
    required this.controller,
    this.validator,
    required this.keyboardType,
    this.icon,
    required this.readOnly,
    this.onChanged,
    this.inputFormatters,
    this.maxLength
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: this.controller,
        validator: this.validator,
        keyboardType: this.keyboardType,
        readOnly: this.readOnly,
        onChanged: this.onChanged,
        inputFormatters: this.inputFormatters,
        maxLength: this.maxLength,
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
        decoration: InputDecoration(
          labelText: this.label,
          prefixIcon: this.icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: this.readOnly,
          fillColor: this.readOnly ? Colors.grey[200] : null,
        ),
      ),
    );
  }


}