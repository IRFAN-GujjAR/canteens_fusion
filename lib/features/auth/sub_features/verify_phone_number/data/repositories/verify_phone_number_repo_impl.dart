import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/data/datasources/verify_phone_number_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/repositories/verify_phone_number_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/send_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';

class VerifyPhoneNumberRepoImpl implements VerifyPhoneNumberRepo {
  final VerifyPhoneNumberDataSource _verifyPhoneNumberDataSource;

  VerifyPhoneNumberRepoImpl(this._verifyPhoneNumberDataSource);

  @override
  Future<void> sendOtp(VerifyPhoneNumberSendOtpParams params) async {
    await _verifyPhoneNumberDataSource.sendOtp(params);
  }

  @override
  Future<void> verifyOtp(VerifyPhoneNumberVerifyOtpParams params) async {
    await _verifyPhoneNumberDataSource.verifyOtp(params);
  }
}
