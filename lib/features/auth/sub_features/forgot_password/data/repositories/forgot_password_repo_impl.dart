import 'package:canteens_fusion/features/auth/sub_features/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/data/models/forgot_password_model.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/repositories/forgot_password_repo.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final ForgotPasswordDataSource _forgotPasswordDataSource;

  ForgotPasswordRepoImpl(this._forgotPasswordDataSource);

  @override
  Future<ForgotPasswordModel> sendPasswordResetEmail(String email) async {
    return await _forgotPasswordDataSource.sendPasswordResetEmail(email);
  }
}
