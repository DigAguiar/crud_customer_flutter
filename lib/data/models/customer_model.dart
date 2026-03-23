
import 'package:hive_flutter/hive_flutter.dart';

part 'customer_model.g.dart';

// lib/data/models/customer_model.dart
@HiveType(typeId: 0)
class CustomerModel extends HiveObject {

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;


  @HiveField(4)
  final String? cep;
  @HiveField(5)
  final String? street;
  @HiveField(6)
  final String? number;
  @HiveField(7)
  final String? complement;
  @HiveField(8)
  final String? neighborhood;
  @HiveField(9)
  final String? city;
  @HiveField(10)
  final String? state;

  CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.cep,
    this.street,
    this.number,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
  });

  bool get isIncomplete => 
    (cep?.isEmpty ?? true) || 
    (street?.isEmpty ?? true) || 
    (number?.isEmpty ?? true) ||
    (complement?.isEmpty ?? true) ||
    (neighborhood?.isEmpty ?? true) ||
    (city?.isEmpty ?? true) ||
    (state?.isEmpty ?? true); 

}