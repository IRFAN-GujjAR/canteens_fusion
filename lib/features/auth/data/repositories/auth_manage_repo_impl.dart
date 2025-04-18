import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:canteens_fusion/features/auth/data/datasources/remote/auth_manage_remote_data_source.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_manage_repo.dart';

final class AuthManageRepoImpl extends AuthManageRepo {
  final AuthLocalDataSource _authLocalDataSource;
  final AuthManageRemoteDataSource _authManageRemoteDataSource;

  AuthManageRepoImpl(
      this._authLocalDataSource, this._authManageRemoteDataSource);

  @override
  UserModel getCurrentUser(UserType userType) {
    return _authLocalDataSource.getCurrentUser(userType);
  }

  @override
  Future<UserModel> reloadUser(UserType userType) async {
    return await _authManageRemoteDataSource.reloadUser(userType);
  }

  @override
  Future<void> changeUserType(UserType userType) async {
    await _authLocalDataSource.changeUserType(userType);
  }
}
