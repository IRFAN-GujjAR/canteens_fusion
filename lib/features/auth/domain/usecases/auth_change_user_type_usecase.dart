import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_manage_repo.dart';

class AuthChangeUserTypeUseCase extends UseCase<void, UserType> {
  final AuthManageRepo _authRepo;

  AuthChangeUserTypeUseCase(this._authRepo);

  @override
  Future<void> call(UserType params) async {
    await _authRepo.changeUserType(params);
  }
}
