import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/repositories/verify_phone_number_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';

class VerifyPhoneNumberVerifyOtpUseCase
    implements UseCase<void, VerifyPhoneNumberVerifyOtpParams> {
  final VerifyPhoneNumberRepo _verifyPhoneNumberRepo;

  VerifyPhoneNumberVerifyOtpUseCase(this._verifyPhoneNumberRepo);
  @override
  Future<void> call(VerifyPhoneNumberVerifyOtpParams params) async {
    await _verifyPhoneNumberRepo.verifyOtp(params);
  }
}
