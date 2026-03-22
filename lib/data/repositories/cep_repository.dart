import 'package:customer_registration/core/constants.dart';
import 'package:dio/dio.dart';

class CepRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getAddressByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCep.length != 8) {
      throw Exception("CEP must have 8 digits.");
    }

    try {
      final response =
          await _dio.get('${AppConstants.viaCepBaseUrl}$cleanCep/json/');

      if (response.data['erro'] == true) {
        throw Exception("CEP não encontrado.");
      }

      return response.data;
    } catch (e) {
      if (e is Exception && e.toString().contains("CEP não encontrado")) {
        rethrow;
      }
      throw Exception("Erro na busca do CEP. -> " + e.toString());
    }
  }
}
