import 'package:canteens_fusion/features/app_launch/domain/entities/app_launch_entity.dart';

class AppLaunchModel extends AppLaunchEntity {
  const AppLaunchModel(
      {required super.showUserTypeSelectionPage,
      required super.userType,
      super.user});
}
