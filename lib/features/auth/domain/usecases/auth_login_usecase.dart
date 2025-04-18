import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_repo.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';

class AuthLoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepo _authRepo;

  const AuthLoginUseCase(this._authRepo);

  @override
  Future<UserEntity> call(LoginParams params) async {
    return await _authRepo.login(params);
  }
}
