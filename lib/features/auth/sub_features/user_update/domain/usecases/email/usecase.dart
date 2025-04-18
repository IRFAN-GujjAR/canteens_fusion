import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email/params.dart';

class UserUpdateEmailUseCase implements UseCase<void, UserUpdateEmailParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdateEmailUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdateEmailParams params) async {
    await _updateRepo.updateEmail(params);
  }
}
