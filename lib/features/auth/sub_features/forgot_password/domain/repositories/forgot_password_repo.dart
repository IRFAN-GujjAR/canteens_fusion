import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/entities/forgot_password_entity.dart';

abstract class ForgotPasswordRepo {
  Future<ForgotPasswordEntity> sendPasswordResetEmail(String email);
}
