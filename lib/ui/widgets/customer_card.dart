

import 'package:customer_registration/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {

  final CustomerModel customer;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onDelete,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: this.onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Text(
            customer.name[0].toUpperCase(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
          ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(customer.email, style: TextStyle(color: Colors.grey[600])),
            Text(customer.phone, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: this.onDelete,
        ),
      ),
    );
  
  }
}