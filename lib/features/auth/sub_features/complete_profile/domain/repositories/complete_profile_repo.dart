import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/complete_profile/domain/use_cases/params/complete_profile_params.dart';

abstract class CompleteProfileRepo {
  Future<UserEntity> completeProfile(CompleteProfileParams params);
}
