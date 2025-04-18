import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberSendOtpParams extends Equatable {
  final String phoneNumber;
  final void Function() onVerificationCompleted;
  final void Function(FirebaseAuthException e) onVerificationFailed;
  final void Function() onCodeSent;

  const VerifyPhoneNumberSendOtpParams(
      {required this.phoneNumber,
      required this.onVerificationCompleted,
      required this.onVerificationFailed,
      required this.onCodeSent});

  @override
  List<Object?> get props =>
      [phoneNumber, onVerificationCompleted, onVerificationFailed, onCodeSent];
}
