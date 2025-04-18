import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/send_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyPhoneNumberDataSource {
  Future<void> sendOtp(VerifyPhoneNumberSendOtpParams params);
  Future<void> verifyOtp(VerifyPhoneNumberVerifyOtpParams params);
}

class VerifyPhoneNumberDataSourceImpl implements VerifyPhoneNumberDataSource {
  final FirebaseAuth _firebaseAuth;

  VerifyPhoneNumberDataSourceImpl(this._firebaseAuth);

  String _verificationId = '';

  @override
  Future<void> sendOtp(VerifyPhoneNumberSendOtpParams params) async {
    await FirebaseAuthUtils.verifyPhoneNumber(
      _firebaseAuth,
      phoneNumber: params.phoneNumber,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        printDebugMesg(
            dartFileName: runtimeType.toString(), msg: credential.toString());
        params.onVerificationCompleted();
      },
      verificationFailed: (FirebaseAuthException e) {
        printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
        params.onVerificationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        params.onCodeSent();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        printDebugMesg(
            dartFileName: runtimeType.toString(),
            msg: 'codeAutoRetrievalTimeout : $verificationId');
      },
    );
  }

  @override
  Future<void> verifyOtp(VerifyPhoneNumberVerifyOtpParams params) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: params.otp);
    await FirebaseAuthUtils.verifySMSOtp(_firebaseAuth.currentUser!,
        credential: credential);
  }
}
