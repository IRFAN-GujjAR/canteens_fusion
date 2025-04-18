import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

part 'auth/verify/phone_number/firebase_verify_phone_number_exceptions_utils.dart';
part 'auth/forgot_password/forgot_password_exceptions_utils.dart';
part 'auth/link_credential/link_with_credential_exceptions_utils.dart';
part 'auth/login/login_firebase_exceptions_utils.dart';
part 'auth/signup/signup_firebase_exceptions_utils.dart';
part 'auth/verify/email/firebase_verify_email_exceptions_utils.dart';
part 'complete_customer_profile/complete_customer_profile_exceptions_utils.dart';

abstract class CustomFirebaseExceptionsUtils {
  static const userDisabled = 'user-disabled';
  static const tooManyRequests = 'too-many-requests';
  static const networkRequestFailed = 'network-request-failed';
  static const unavailable = 'unavailable';
  static const unexpectedErrorMsg =
      'An unexcepcted error has occurred. Please try again later.';

  String? getErrorMsg(dynamic e) {
    if (e is TimeoutException) {
      return 'Please check your internet connection';
    } else if (e is FirebaseException) {
      switch (e.code) {
        case tooManyRequests:
          return 'You have made too many requests. Please try again later.';
        case networkRequestFailed:
        case unavailable:
          return 'Please check your internet connection';
        case userDisabled:
          return 'You are blocked from accessing Canteens Fusion. You have violated our terms and conditions.';
        default:
          return null;
      }
    }
    return null;
  }

  CustomFirebaseExceptionType? getExceptionType(dynamic e) {
    if (e is TimeoutException) {
      return CustomFirebaseExceptionType.timeout;
    } else if (e is FirebaseException) {
      switch (e.code) {
        case tooManyRequests:
          return CustomFirebaseExceptionType.tooManyRequests;
        case networkRequestFailed:
        case unavailable:
          return CustomFirebaseExceptionType.networkRequestFailed;
        case userDisabled:
          return CustomFirebaseExceptionType.userDisabled;
        default:
          return null;
      }
    }
    return null;
  }
}

enum CustomFirebaseExceptionType {
  timeout,
  networkRequestFailed,
  tooManyRequests,
  userDisabled,
  providerAlreadyLinked,
  invalidCredentials,
  crednetialAlreadyInUse,
  emailAlreadyInUse,
  invalidEmail,
  userNotFound,
  invalidVerificationCode,
  invalidVerificationId,
  weakPassword,
  wrongPassword,
  unexpected,
  sessionExpired,
  invalidPhoneNumber
}
