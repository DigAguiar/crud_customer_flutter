
class CustomerValidator {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty){
      return "Required field.";
    } 
    if (name.trim().length < 3) {
      return "Minimum of 3 characters";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Required field.";
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) {
      return "Invalid E-mail.";
    }
    return null;
  }
}
