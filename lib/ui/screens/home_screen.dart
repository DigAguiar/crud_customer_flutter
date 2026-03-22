
import 'package:customer_registration/logic/controllers/customer_controller.dart';
import 'package:customer_registration/ui/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final customerState = ref.watch(customerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Clientes"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      body: customerState.when(
        error: (err, stack) => Center(child: Text('Erro ao carregar: $err'),), 
        loading: () => Center(child: CircularProgressIndicator()),
        data: (customers) {
          if(customers.isEmpty) {
            return const Center(child: Text('Nenhum cliente cadastrado'),
          );
          }
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return CustomerCard(
                customer: customer, 
                onDelete: () {
                  ref.read(customerControllerProvider.notifier).removeCustomer(customer.id);
                }, 
                onTap: () {
                  
                }
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navegacao para tela de cadastro
        },
        tooltip: 'Adicionar cliente',
        child: const Icon(Icons.add),
      ),
    );   
  }

}