part of '../../custom_firebase_exceptions_utils.dart';

class SignupFirebaseExceptionsUtils extends CustomFirebaseExceptionsUtils {
  //Thrown if there already exists an account with the given email address.
  static const emailAlreadyInUse = 'email-already-in-use';

  //Thrown if the email address is not valid.
  static const invalidEmail = 'invalid-email';

  //Thrown if the password is not strong enough.
  static const weakPassword = 'weak-password';

  @override
  String getErrorMsg(dynamic e) {
    final msg = super.getErrorMsg(e);
    if (msg == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case emailAlreadyInUse:
            return 'This email is already associated with another account. Please use other email';
          case invalidEmail:
            return 'This email is invalid. Please use a valid email';
          case weakPassword:
            return 'Please use a strong password, this password is too weak.';
          default:
            return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
        }
      } else {
        return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
      }
    }
    return msg;
  }

  @override
  CustomFirebaseExceptionType getExceptionType(dynamic e) {
    final exceptionType = super.getExceptionType(e);
    if (exceptionType == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case emailAlreadyInUse:
            return CustomFirebaseExceptionType.emailAlreadyInUse;
          case invalidEmail:
            return CustomFirebaseExceptionType.invalidEmail;
          case weakPassword:
            return CustomFirebaseExceptionType.weakPassword;
          default:
            return CustomFirebaseExceptionType.unexpected;
        }
      } else {
        return CustomFirebaseExceptionType.unexpected;
      }
    }
    return exceptionType;
  }
}
