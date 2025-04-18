part of '../../../custom_firebase_exceptions_utils.dart';

class FirebaseVerifyPhoneNumberExceptionsUtils
    extends CustomFirebaseExceptionsUtils {
  static const invalidPhoneNumber = 'invalid-phone-number';

  @override
  String getErrorMsg(dynamic e) {
    final msg = super.getErrorMsg(e);
    if (msg == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case invalidPhoneNumber:
            return 'Please enter a valid phone number. This phone number is invalid';
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
        if (e.code == invalidPhoneNumber) {
          return CustomFirebaseExceptionType.invalidPhoneNumber;
        }
      }
      return CustomFirebaseExceptionType.unexpected;
    } else {
      return exceptionType;
    }
  }
}
