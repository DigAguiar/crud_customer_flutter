
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/providers/customer_filter_provider.dart';

class CustomerSearchBar extends ConsumerWidget {
  const CustomerSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (value) => ref.read(customerSearchQueryProvider.notifier).state = value,
        decoration: InputDecoration(
          hintText: "Buscar cliente...",
          prefixIcon: const Icon(Icons.search, color: Color(0xFF070E91)),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}