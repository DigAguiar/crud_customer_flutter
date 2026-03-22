

import 'package:customer_registration/core/utils/customer_validator.dart';
import 'package:customer_registration/data/models/customer_model.dart';
import 'package:customer_registration/data/repositories/customer_repository.dart';

class CustomerService {

  final CustomerRepository _repository = CustomerRepository();
  CustomerService();

  Future<List<CustomerModel>> findAllCustomer() async {
    return _repository.findAll();
  }

  Future<CustomerModel> findCustomerById(String customerId) async {
    final customer = await _repository.findById(customerId);
    if(customer == null) {
      throw Exception("ID doesn't exist");
    }
      return customer;

  }

  Future<void> saveCustomer(CustomerModel customer) async {

  final nameError = CustomerValidator.validateName(customer.name);
  if (nameError != null) {
    throw Exception(nameError);
  }

  final emailError = CustomerValidator.validateEmail(customer.email);
  if (emailError != null) {
    throw Exception(emailError);
  }

  await _repository.save(customer);
}

  Future<void> deleteCustomer(String customerId) async {
    
    await findCustomerById(customerId);
    
    await _repository.delete(customerId);
  }

}