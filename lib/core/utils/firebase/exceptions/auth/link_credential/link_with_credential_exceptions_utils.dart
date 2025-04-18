part of '../../custom_firebase_exceptions_utils.dart';

enum AuthCredentialType {
  email,
  phoneNumber,
}

extension AuthCredentialTypeExtension on AuthCredentialType {
  bool get isEmail => this == AuthCredentialType.email;
  bool get isPhoneNumber => this == AuthCredentialType.phoneNumber;

  String get name => isPhoneNumber ? 'phone number' : 'email';
}

class LinkWithCredentialExceptionsUtils extends CustomFirebaseExceptionsUtils {
  final AuthCredentialType _type;

  LinkWithCredentialExceptionsUtils(
      {AuthCredentialType type = AuthCredentialType.phoneNumber})
      : _type = type;

  /* Thrown if the provider has already been linked to the user. This error is thrown even 
  if this is not the same provider's account that is currently linked to the user.*/
  static const providerAlreadyLinked = 'provider-already-linked';

  /* Thrown if the provider's credential is not valid. This can happen if it has already expired
  when calling link, or if it used invalid token(s). See the Firebase documentation for your provider, 
  and make sure you pass in the correct parameters to the credential method.*/
  static const invalidCredentials = 'invalid-credential';

  /* Thrown if the account corresponding to the credential already exists among your users, or 
  is already linked to a Firebase User. For example, this error could be thrown if you are 
  upgrading an anonymous user to a Google user by linking a Google credential to it and the 
  Google credential used is already associated with an existing Firebase Google user. 
  The fields email, phoneNumber, and credential ([AuthCredential]) may be provided, 
  depending on the type of credential. You can recover from this error by signing in 
  with credential directly via [signInWithCredential]. Please note, you will not recover 
  from this error if you're using a [PhoneAuthCredential] to link a provider to an account. 
  Once an attempt to link an account has been made, a new sms code is required to sign in the user.*/
  static const credentialAlreadyInUse = 'credential-already-in-use';

  /*Thrown if the email corresponding to the credential already exists among your users. 
  When thrown while linking a credential to an existing user, an email and credential ([AuthCredential]) 
  fields are also provided. You have to link the credential to the existing user with that email 
  if you wish to continue signing in with that credential. To do so, call [fetchSignInMethodsForEmail], 
  sign in to email via one of the providers returned and then [User.linkWithCredential] the original 
  credential to that newly signed in user.*/
  static const emailAlreadyInUse = 'email-already-in-use';

  /* Thrown if the email used in a [EmailAuthProvider.credential] is invalid.
  Thrown if the password used in a [EmailAuthProvider.credential] is not correct or when the user 
  associated with the email does not have a password.*/
  static const invalidEmail = 'invalid-email';

  /*Thrown if the credential is a [PhoneAuthProvider.credential] and the verification code of 
  the credential is not valid.*/
  static const invalidVerificationCode = 'invalid-verification-code';

  /*Thrown if the credential is a [PhoneAuthProvider.credential] and the 
  verification ID of the credential is not valid.*/
  static const invalidVerificationId = 'invalid-verification-id';

  //Thrown if Verification code session expired
  static const sessionExpired = 'session-expired';

  @override
  String getErrorMsg(dynamic e) {
    final msg = super.getErrorMsg(e);
    if (msg == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case providerAlreadyLinked:
            return 'This ${_type.name} is already linked';
          case invalidCredentials:
            return 'Verification code expired. Please resend code';
          case credentialAlreadyInUse:
            return 'This ${_type.name} is already associated with another account. Please use a different ${_type.name}';
          case emailAlreadyInUse:
            return 'This email is already associated with another account. Please use a different email';
          case invalidEmail:
            return 'This email is invalid. Please use a valid email';
          case invalidVerificationCode:
            return 'Verification code is invalid. Please use correct verification code';
          case sessionExpired:
            return 'The SMS code has expired. Please re-send the verification code to try again';
          case invalidVerificationId:
          default:
            return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
        }
      } else {
        return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
      }
    } else {
      return msg;
    }
  }

  @override
  CustomFirebaseExceptionType getExceptionType(dynamic e) {
    final exceptionType = super.getExceptionType(e);
    if (exceptionType == null) {
      if (e is FirebaseException) {
        switch (e.code) {
          case providerAlreadyLinked:
            return CustomFirebaseExceptionType.providerAlreadyLinked;
          case invalidCredentials:
            return CustomFirebaseExceptionType.invalidCredentials;
          case credentialAlreadyInUse:
            return CustomFirebaseExceptionType.crednetialAlreadyInUse;
          case emailAlreadyInUse:
            return CustomFirebaseExceptionType.emailAlreadyInUse;
          case invalidEmail:
            return CustomFirebaseExceptionType.invalidEmail;
          case invalidVerificationCode:
            return CustomFirebaseExceptionType.invalidVerificationCode;
          case sessionExpired:
            return CustomFirebaseExceptionType.sessionExpired;
          case invalidVerificationId:
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
