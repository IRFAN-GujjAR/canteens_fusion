import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import '../repositories/complete_profile_repo.dart';
import 'params/complete_profile_params.dart';

final class CompleteCustomerProfileUseCase
    implements UseCase<UserEntity, CompleteProfileParams> {
  final CompleteProfileRepo _customerProfileRepo;

  const CompleteCustomerProfileUseCase(this._customerProfileRepo);

  @override
  Future<UserEntity> call(CompleteProfileParams params) async {
    return await _customerProfileRepo.completeProfile(params);
  }
}
