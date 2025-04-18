import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class FirebaseAuthUtils {
  static const _requestTimeOutSeconds = Duration(seconds: 5);

  static FirebaseAuth get firebaseAuth => locator.get<FirebaseAuth>();

  static Future<void> updateDisplayName(User currentUser,
      {required String displayName}) async {
    await currentUser
        .updateDisplayName(displayName)
        .timeout(_requestTimeOutSeconds);
  }

  static Future<void> updatePhotoUrl(User currentUser,
      {required String photoUrl}) async {
    await currentUser.updatePhotoURL(photoUrl).timeout(_requestTimeOutSeconds);
  }

  static Future<void> updateEmail(User currentUser,
      {required String email}) async {
    await currentUser.updateEmail(email).timeout(_requestTimeOutSeconds);
  }

  static Future<User> reloadUser(FirebaseAuth firebaseAuth) async {
    await firebaseAuth.currentUser!.reload().timeout(_requestTimeOutSeconds);
    return firebaseAuth.currentUser!;
  }

  static Future<void> updatePhoneNumber(User currentUser,
      {required PhoneAuthCredential phoneAuthCredential}) async {
    await currentUser
        .updatePhoneNumber(phoneAuthCredential)
        .timeout(_requestTimeOutSeconds);
  }

  static Future<UserCredential> signInWithEmailAndPassword(
      FirebaseAuth firebaseAuth,
      {required String email,
      required String password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .timeout(_requestTimeOutSeconds);
  }

  static Future<void> signOut(FirebaseAuth firebaseAuth) async {
    return await firebaseAuth.signOut().timeout(_requestTimeOutSeconds);
  }

  static Future<void> sendPasswordResetEmail(FirebaseAuth firebaseAuth,
      {required String email}) async {
    await firebaseAuth
        .sendPasswordResetEmail(email: email)
        .timeout(_requestTimeOutSeconds);
  }

  static Future<UserCredential> createUserWithEmailAndPassword(
      FirebaseAuth firebaseAuth,
      {required String email,
      required String password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .timeout(_requestTimeOutSeconds);
  }

  static Future<void> sendEmailVerification(User currentUser) async {
    await currentUser.sendEmailVerification().timeout(_requestTimeOutSeconds);
  }

  static Future<void> verifyPhoneNumber(FirebaseAuth firebaseAuth,
      {required String phoneNumber,
      required Duration timeout,
      required void Function(PhoneAuthCredential credential)
          verificationCompleted,
      required void Function(FirebaseAuthException e) verificationFailed,
      required void Function(String verificationId, int? resendToken) codeSent,
      required void Function(String verificationId)
          codeAutoRetrievalTimeout}) async {
    await firebaseAuth
        .verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: timeout,
          verificationCompleted: (PhoneAuthCredential credential) {
            verificationCompleted(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            verificationFailed(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            codeSent(verificationId, resendToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            codeAutoRetrievalTimeout(verificationId);
          },
        )
        .timeout(_requestTimeOutSeconds);
  }

  static Future<UserCredential> verifySMSOtp(User currentUser,
      {required AuthCredential credential}) async {
    return await currentUser.linkWithCredential(credential);
  }
}
