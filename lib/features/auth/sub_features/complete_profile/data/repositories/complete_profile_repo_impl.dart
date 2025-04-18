import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/complete_profile/data/data_sources/complete_profile_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/complete_profile/domain/repositories/complete_profile_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/complete_profile/domain/use_cases/params/complete_profile_params.dart';

final class CompleteProfileRepoImpl implements CompleteProfileRepo {
  final CompleteProfileDataSource _dataSource;

  CompleteProfileRepoImpl(this._dataSource);

  @override
  Future<UserEntity> completeProfile(CompleteProfileParams params) async {
    return await _dataSource.completeProfile(params);
  }
}
