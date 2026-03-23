class CustomerValidator {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Campo obrigatório.";
    }
    if (name.trim().length < 3) {
      return "Minimo de 3 caracter";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Campo obrigatório.";
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) {
      return "E-mail invalido.";
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return "Campo obrigatório";
    }

    if (phone.length < 15) {
      return "Telefone incompleto.";
    }
    return null;
  }

  static String? validateCep(String? cep, String? apiErrorMessage) {
    if (cep == null || cep.isEmpty) return null;
    
    if (cep.length < 9) return "CEP Incompleto";

    return apiErrorMessage;
  }
}
