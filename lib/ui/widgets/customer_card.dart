import 'package:customer_registration/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CustomerCard(
      {super.key,
      required this.customer,
      required this.onDelete,
      required this.onTap});

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
        title: Text(customer.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(customer.email, style: TextStyle(color: Colors.grey[600])),
            if (customer.phone != null && customer.phone!.isNotEmpty)
              Text(customer.phone!, style: TextStyle(color: Colors.grey[600])),
            if (customer.isIncomplete)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orangeAccent),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          size: 14, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        "Dados incompletos",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
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
