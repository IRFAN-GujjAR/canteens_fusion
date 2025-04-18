import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/domain/repositories/verify_email_repo.dart';

class SendVerifyEmailUseCase implements UseCaseWithoutParams<void> {
  final VerifyEmailRepo _verifyEmailRepo;

  SendVerifyEmailUseCase(this._verifyEmailRepo);

  @override
  Future<void> get call async => await _verifyEmailRepo.sendVerifyEmail;
}
