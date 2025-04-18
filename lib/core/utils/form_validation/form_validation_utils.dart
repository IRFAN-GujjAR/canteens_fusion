import 'package:canteens_fusion/core/entities/signup_password_model.dart';
import 'package:email_validator/email_validator.dart';

final class FormValidationUtils {
  static String? emailValidator(String? txt) {
    if (txt == null || txt.isEmpty) return "Email is required";
    if (!EmailValidator.validate(txt)) return "Enter valid email";
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    const enterNumberMsg = "Please enter phone number";
    if (value == null || value.isEmpty) return enterNumberMsg;
    var number = value.trim();
    if (number == '+92') return enterNumberMsg;
    number = number.replaceAll(' ', '');
    if (number.length < 13) {
      return 'Please enter complete number';
    }
    return null;
  }

  static String? otpValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter otp code";
    if (value.length < 6) {
      return "Please enter complete code";
    }
    return null;
  }

  static String? passwordLoginValidator(String? txt) {
    if (txt == null || txt.isEmpty) return "Enter a password";
    return null;
  }

  static SignupPasswordEntity passwordSignupValidator(String password) {
    final passwordValidator = _PasswordValidator();
    return SignupPasswordEntity(
        hasMinLength: passwordValidator.hasMinLength(password, 6),
        hasMinLowercase: passwordValidator.hasMinLowercase(password, 1),
        hasMinUppercase: passwordValidator.hasMinUppercase(password, 1),
        hasDigit: passwordValidator.hasMinNumericChar(password, 1),
        hasMinSpecialChar: passwordValidator.hasMinSpecialChar(password, 1));
  }

  static String? nameValidator(String? txt) {
    if (txt == null || txt.isEmpty) return "Please enter your name";
    return null;
  }
}

class _PasswordValidator {
  /// Checks if password has minLength
  bool hasMinLength(String password, int minLength) {
    return password.length >= minLength ? true : false;
  }

  /// Checks if password has at least normal char letter matches
  bool hasMinNormalChar(String password, int normalCount) {
    String pattern = '^(.*?[A-Z]){$normalCount,}';
    return password.toUpperCase().contains(RegExp(pattern));
  }

  /// Checks if password has at least uppercaseCount uppercase letter matches
  bool hasMinUppercase(String password, int uppercaseCount) {
    String pattern = '^(.*?[A-Z]){$uppercaseCount,}';
    return password.contains(RegExp(pattern));
  }

  /// Checks if password has at least lowercaseCount lowercase letter matches
  bool hasMinLowercase(String password, int lowercaseCount) {
    String pattern = '^(.*?[a-z]){$lowercaseCount,}';
    return password.contains(RegExp(pattern));
  }

  /// Checks if password has at least numericCount numeric character matches
  bool hasMinNumericChar(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return password.contains(RegExp(pattern));
  }

  //Checks if password has at least specialCount special character matches
  bool hasMinSpecialChar(String password, int specialCount) {
    String pattern =
        // ignore: prefer_interpolation_to_compose_strings
        r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
    return password.contains(RegExp(pattern));
  }
}
