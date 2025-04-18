import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_manage_repo.dart';

class AuthCurrentUserUseCase
    implements UseCaseWithoutAsync<UserEntity, UserType> {
  final AuthManageRepo _authRepo;

  const AuthCurrentUserUseCase(this._authRepo);

  @override
  UserEntity call(UserType params) {
    return _authRepo.getCurrentUser(params);
  }
}
