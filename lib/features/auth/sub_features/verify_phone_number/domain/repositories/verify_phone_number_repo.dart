import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/send_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';

abstract class VerifyPhoneNumberRepo {
  Future<void> sendOtp(VerifyPhoneNumberSendOtpParams params);
  Future<void> verifyOtp(VerifyPhoneNumberVerifyOtpParams params);
}
