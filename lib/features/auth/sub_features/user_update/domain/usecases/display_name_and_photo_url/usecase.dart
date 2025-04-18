import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';

class UserUpdateDisplayNameAndPhotoUrlUseCase
    implements UseCase<void, UserUpdateDisplayNameAndPhotoParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdateDisplayNameAndPhotoUrlUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdateDisplayNameAndPhotoParams params) async {
    await _updateRepo.updateDisplayNameAndPhotoUrl(params);
  }
}
