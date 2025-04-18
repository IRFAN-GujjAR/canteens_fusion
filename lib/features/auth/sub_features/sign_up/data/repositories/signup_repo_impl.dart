import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/data/data_sources/signup_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/repositories/signup_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';

class SignupRepoImpl implements SignupRepo {
  final SignupDataSource _signupDataSource;

  SignupRepoImpl(this._signupDataSource);

  @override
  Future<UserModel> registerUser(SignupRegisterUserParams params) async {
    return await _signupDataSource.registerUser(params);
  }
}
