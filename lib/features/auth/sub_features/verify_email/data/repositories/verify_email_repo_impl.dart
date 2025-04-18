import 'package:canteens_fusion/features/auth/sub_features/verify_email/data/datasources/verify_email_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/domain/repositories/verify_email_repo.dart';

class VerifyEmailRepoImpl implements VerifyEmailRepo {
  final VerifyEmailDataSource _verifyEmailDataSource;

  VerifyEmailRepoImpl(this._verifyEmailDataSource);

  @override
  Future<void> get sendVerifyEmail async =>
      await _verifyEmailDataSource.sendVerifyEmail;
}
