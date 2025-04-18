import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';

abstract class AuthRepo {
  Future<UserEntity> login(LoginParams loginParams);
}
