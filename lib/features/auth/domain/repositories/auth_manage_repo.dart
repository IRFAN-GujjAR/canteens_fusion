import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';

abstract class AuthManageRepo {
  Future<UserEntity> reloadUser(UserType userType);
  UserEntity getCurrentUser(UserType userType);
  Future<void> changeUserType(UserType userType);
}
