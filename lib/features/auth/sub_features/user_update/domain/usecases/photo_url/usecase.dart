import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/params.dart';

class UserUpdatePhotoUrlUseCase
    implements UseCase<void, UserUpdatePhotoParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdatePhotoUrlUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdatePhotoParams params) async {
    await _updateRepo.updatePhotoUrl(params);
  }
}
