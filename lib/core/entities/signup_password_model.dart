final class SignupPasswordEntity {
  final bool hasMinLength;
  final bool hasMinLowercase;
  final bool hasMinUppercase;
  final bool hasDigit;
  final bool hasMinSpecialChar;

  const SignupPasswordEntity(
      {required this.hasMinLength,
      required this.hasMinLowercase,
      required this.hasMinUppercase,
      required this.hasDigit,
      required this.hasMinSpecialChar});

  bool get hasAllRequirementsMet =>
      hasMinLength &&
      hasMinLowercase &&
      hasMinUppercase &&
      hasDigit &&
      hasMinSpecialChar;

  String? get requirementMsg {
    if (!hasMinLength) {
      return 'Must be minimum 6 characters';
    } else if (!hasMinLowercase) {
      return 'Add lowercase letter';
    } else if (!hasMinUppercase) {
      return 'Add uppercase letter';
    } else if (!hasDigit) {
      return 'Atleast one digit';
    } else if (!hasMinSpecialChar) {
      return 'Add special character';
    }

    return null;
  }
}
