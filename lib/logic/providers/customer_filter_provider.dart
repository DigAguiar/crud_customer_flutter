import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/customer_controller.dart';
import '../../data/models/customer_model.dart';

// 1. O estado simples do que está sendo digitado
final customerSearchQueryProvider = StateProvider<String>((ref) => "");

// 2. O "Motor de Busca": Ele combina o dado bruto do Controller com a Query
final filteredCustomersProvider = Provider<AsyncValue<List<CustomerModel>>>((ref) {

  final customersAsync = ref.watch(customerControllerProvider);

  final query = ref.watch(customerSearchQueryProvider).toLowerCase();

  return customersAsync.whenData((customers) {
    if (query.isEmpty) return customers;

    return customers.where((customer) {
      return customer.name.toLowerCase().contains(query) ||
             customer.email.toLowerCase().contains(query);
    }).toList();
  });
});