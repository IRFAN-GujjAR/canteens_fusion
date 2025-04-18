part of '../../custom_firebase_exceptions_utils.dart';

class LoginFirebaseExceptionsUtils extends CustomFirebaseExceptionsUtils {
  //Thrown if email or password is incorrect.
  static const invalidCredential = 'invalid-credential';
  static const invalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';

  //Thrown if the email address is not valid.
  static const invalidEmail = 'invalid-email';

  //Thrown if there is no user corresponding to the given email.
  static const userNotFound = 'user-not-found';

  //Thrown if the password is invalid for the given email, or the account
  //corresponding to the email does not have a password set.
  static const wrongPassword = 'wrong-password';

  @override
  String getErrorMsg(dynamic e) {
    final errorMsg = super.getErrorMsg(e);
    if (errorMsg == null) {
      if (e is FirebaseException) {
        if (e.code == CustomFirebaseExceptionsUtils.tooManyRequests) {
          if (e.message != null) {
            return e.message!;
          }
        }
        switch (e.code) {
          case invalidEmail:
            return 'This email is invalid. Please use a valid email';
          case userNotFound:
            return 'Verification code is invalid. Please use correct verification code';
          case wrongPassword:
            return 'Your password is incorrect. Please enter correct password';
          case invalidCredential:
          case invalidLoginCredentials:
            return 'Email or Password is incorrect. Please verify both email and password are correct.';
          default:
            return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
        }
      } else {
        return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
      }
    }
    return errorMsg;
  }

  @override
  CustomFirebaseExceptionType getExceptionType(dynamic e) {
    final exceptionType = super.getExceptionType(e);
    if (exceptionType == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case invalidEmail:
            return CustomFirebaseExceptionType.invalidEmail;
          case userNotFound:
            return CustomFirebaseExceptionType.userNotFound;
          case wrongPassword:
            return CustomFirebaseExceptionType.wrongPassword;
          case invalidCredential:
          case invalidLoginCredentials:
            return CustomFirebaseExceptionType.invalidCredentials;
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
