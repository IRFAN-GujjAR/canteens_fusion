import 'package:canteens_fusion/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/domain/repositories/auth_repo.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';

final class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<UserModel> login(LoginParams loginParams) async {
    return await _authRemoteDataSource.signIn(loginParams);
  }
}
