part of '../../../custom_firebase_exceptions_utils.dart';

class FirebaseVerifyEmailExceptionsUtils extends CustomFirebaseExceptionsUtils {
  @override
  String getErrorMsg(dynamic e) {
    final errorMsg = super.getErrorMsg(e);
    if (errorMsg == null) {
      return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
    }
    return errorMsg;
  }
}
