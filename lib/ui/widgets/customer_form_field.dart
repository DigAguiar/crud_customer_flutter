
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final bool readOnly;
  final int? maxLength;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const CustomerFormField({
    super.key, 
    required this.label,
    required this.controller,
    this.validator,
    required this.keyboardType,
    this.icon,
    required this.readOnly,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
        focusNode: focusNode,

        autovalidateMode: AutovalidateMode.onUserInteraction, 
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: readOnly,
          fillColor: readOnly ? Colors.grey[200] : null,
          errorMaxLines: 2, 
        ),
      ),
    );
  }
}