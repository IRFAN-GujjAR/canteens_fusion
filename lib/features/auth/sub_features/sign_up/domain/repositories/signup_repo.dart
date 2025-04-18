
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';

abstract class SignupRepo{
  Future<UserEntity> registerUser(SignupRegisterUserParams params);
}