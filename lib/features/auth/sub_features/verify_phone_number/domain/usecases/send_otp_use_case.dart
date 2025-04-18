import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/repositories/verify_phone_number_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/send_otp_params.dart';

class VerifyPhoneNumberSendOtpUseCase
    implements UseCase<void, VerifyPhoneNumberSendOtpParams> {
  final VerifyPhoneNumberRepo _verifyPhoneNumberRepo;

  VerifyPhoneNumberSendOtpUseCase(this._verifyPhoneNumberRepo);

  @override
  Future<void> call(VerifyPhoneNumberSendOtpParams params) async {
    await _verifyPhoneNumberRepo.sendOtp(params);
  }
}
