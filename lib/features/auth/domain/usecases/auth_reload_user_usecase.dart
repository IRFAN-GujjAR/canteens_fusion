import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_manage_repo.dart';

class AuthReloadUserUseCase implements UseCase<UserEntity, UserType> {
  final AuthManageRepo _authRepo;

  const AuthReloadUserUseCase(this._authRepo);

  @override
  Future<UserEntity> call(UserType userType) async {
    return await _authRepo.reloadUser(userType);
  }
}
