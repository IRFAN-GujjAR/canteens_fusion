import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/params.dart';

class UserUpdateDisplayNameUseCase
    implements UseCase<void, UserUpdateDisplayNameParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdateDisplayNameUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdateDisplayNameParams params) async {
    await _updateRepo.updateDisplayName(params);
  }
}
