import 'package:customer_registration/data/models/customer_model.dart';
import 'package:customer_registration/data/repositories/customer_repository.dart';
import 'package:customer_registration/logic/services/customer_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customer_controller.g.dart';

@riverpod
class CustomerController extends _$CustomerController {
  late final CustomerService _service = CustomerService();

  @override
  Future<List<CustomerModel>> build() async {
    return _service.findAllCustomer();
  }

  Future<void> addCustomer(CustomerModel customer) async {
    state = await AsyncValue.guard(() async {
      await _service.saveCustomer(customer);
      return build();
    });
  }

  Future<void> removeCustomer(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.deleteCustomer(id);
      return build();
    });
  }

  Future<CustomerModel> findById(String customerId) async {
    return await _service.findCustomerById(customerId);
  }
}
