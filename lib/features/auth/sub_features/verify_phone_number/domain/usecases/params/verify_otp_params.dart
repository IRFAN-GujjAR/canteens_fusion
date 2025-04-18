import 'package:equatable/equatable.dart';

class VerifyPhoneNumberVerifyOtpParams extends Equatable {
  final String otp;

  const VerifyPhoneNumberVerifyOtpParams({required this.otp});

  @override
  List<Object?> get props => [otp];
}
