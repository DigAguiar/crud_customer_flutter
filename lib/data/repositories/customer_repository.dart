

import 'package:customer_registration/data/models/customer_model.dart';
import 'package:hive_flutter/adapters.dart';

class CustomerRepository {
  static const String boxName = 'customer_box';

  Future<Box<CustomerModel>> _openBox() async {
    return await Hive.openBox<CustomerModel>(boxName);
  }

  Future<List<CustomerModel>> findAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // o box.put serve também como UPDATE
  Future<void> save(CustomerModel customer) async {
    final box = await _openBox();
    await box.put(customer.id, customer);
  }

  Future<void> delete(String customerId) async {
    final box = await _openBox();
    await box.delete(customerId);
  }

}