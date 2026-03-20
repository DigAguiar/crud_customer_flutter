

import 'package:dio/dio.dart';

class CepRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getAddressByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if(cleanCep.length != 8) {
      throw Exception("CEP must have 8 digits.");
    }

    try{
      final response = await _dio.get('https://viacep.com.br/ws/$cleanCep/json');

      if(response.data['error'] == true ) {
        throw Exception("CEP not found.");
      }

      return response.data;

    }catch(e){
      throw Exception("Error -> " + e.toString());
    }

  }

}