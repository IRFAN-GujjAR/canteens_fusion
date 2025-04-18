import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/app_launch/domain/entities/app_launch_entity.dart';
import 'package:canteens_fusion/features/app_launch/domain/repositories/app_launch_repo.dart';

class AppLaunchUseCase extends UseCaseWithoutParams<AppLaunchEntity> {
  final AppLaunchRepo _appLaunchRepo;

  AppLaunchUseCase(this._appLaunchRepo);

  @override
  Future<AppLaunchEntity> get call async {
    return await _appLaunchRepo.check;
  }
}
