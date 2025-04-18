import 'package:canteens_fusion/features/app_launch/domain/entities/app_launch_entity.dart';

abstract class AppLaunchRepo {
  Future<AppLaunchEntity> get check;
}
