import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/repositories/forgot_password_repo.dart';

class SendPasswordResetEmailUseCase
    extends UseCase<ForgotPasswordEntity, String> {
  final ForgotPasswordRepo _forgotPasswordRepo;

  SendPasswordResetEmailUseCase(this._forgotPasswordRepo);

  @override
  Future<ForgotPasswordEntity> call(String params) async {
    return await _forgotPasswordRepo.sendPasswordResetEmail(params);
  }
}
