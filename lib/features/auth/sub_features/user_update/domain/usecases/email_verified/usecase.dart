import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/params.dart';

class UserUpdateEmailVerifiedUseCase
    implements UseCase<void, UserUpdateEmailVerifiedParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdateEmailVerifiedUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdateEmailVerifiedParams params) async {
    await _updateRepo.updateEmailVerified(params);
  }
}
