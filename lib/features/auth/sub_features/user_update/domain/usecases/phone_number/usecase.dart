import 'package:canteens_fusion/core/usecase/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';

class UserUpdatePhoneNumberUseCase
    implements UseCase<void, UserUpdatePhoneNumberParams> {
  final UserUpdateRepo _updateRepo;

  UserUpdatePhoneNumberUseCase(this._updateRepo);

  @override
  Future<void> call(UserUpdatePhoneNumberParams params) async {
    await _updateRepo.updatePhoneNumber(params);
  }
}
