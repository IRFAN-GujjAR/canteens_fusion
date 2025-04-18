part of '../../custom_firebase_exceptions_utils.dart';

class ForgotPasswordExceptionsUtils extends CustomFirebaseExceptionsUtils {
  // Thrown if the email address is not valid.
  static const invalidEmail = 'invalid-email';

  // An Android package name must be provided if the Android app is required to be installed.
  // static const missingAndroidPkgName = 'auth/missing-android-pkg-name';

  // A continue URL must be provided in the request.
  // static const missingContinueUri = 'auth/missing-continue-uri';

  // An iOS Bundle ID must be provided if an App Store ID is provided.
  // static const missingIOSBundleId = 'auth/missing-ios-bundle-id';

  // The continue URL provided in the request is invalid.
  // static const invalidContinueUri = 'auth/invalid-continue-uri';

  // The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.
  // static const unAuthorizedContinueUri = 'auth/unauthorized-continue-uri';

  // Thrown if there is no user corresponding to the email address.
  static const userNotFound = 'user-not-found';

  @override
  String getErrorMsg(dynamic e) {
    final msg = super.getErrorMsg(e);
    if (msg == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case invalidEmail:
            return 'Please enter a valid email. This email is invalid';
          case userNotFound:
            return 'This email is not associated with any account';
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
          case invalidEmail:
            return CustomFirebaseExceptionType.invalidEmail;
          case userNotFound:
            return CustomFirebaseExceptionType.userNotFound;
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
