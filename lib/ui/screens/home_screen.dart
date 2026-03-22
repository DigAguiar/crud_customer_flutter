
import 'package:customer_registration/logic/controllers/customer_controller.dart';
import 'package:customer_registration/logic/providers/customer_filter_provider.dart';
import 'package:customer_registration/ui/screens/customer_registration_screen.dart';
import 'package:customer_registration/ui/widgets/customer_card.dart';
import 'package:customer_registration/ui/widgets/customer_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  // 1. Assistimos o estado filtrado (ele é quem manda na lista agora)
  final filteredState = ref.watch(filteredCustomersProvider);
  // Mantemos o original apenas para saber se a base está realmente vazia
  final customerState = ref.watch(customerControllerProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Lista de Clientes"),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: Column(
      children: [
        // 2. Chamada do seu Widget de busca
        const CustomerSearchBar(),

        // 3. O Expanded garante que a lista ocupe o espaço que sobrar
        Expanded(
          child: filteredState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Erro ao carregar: $err')),
            data: (customers) {
              // Verificação inteligente:
              // Se a lista original está vazia -> "Nenhum cliente cadastrado"
              // Se a lista filtrada está vazia -> "Nenhum resultado para a busca"
              if (customers.isEmpty) {
                final isSearching = ref.read(customerSearchQueryProvider).isNotEmpty;
                return Center(
                  child: Text(isSearching 
                    ? 'Nenhum resultado para a busca' 
                    : 'Nenhum cliente cadastrado'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerRegistrationScreen(customer: customer),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerRegistrationScreen()),
        );
      },
      tooltip: 'Adicionar cliente',
      child: const Icon(Icons.add),
    ),
  );
}

}