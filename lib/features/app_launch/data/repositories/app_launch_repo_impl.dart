import 'package:canteens_fusion/features/app_launch/data/datasources/app_launch_data_source.dart';
import 'package:canteens_fusion/features/app_launch/data/models/app_launch_model.dart';
import 'package:canteens_fusion/features/app_launch/domain/repositories/app_launch_repo.dart';

class AppLaunchRepoImpl implements AppLaunchRepo {
  final AppLaunchDataSource _appLaunchDataSource;

  AppLaunchRepoImpl(this._appLaunchDataSource);

  @override
  Future<AppLaunchModel> get check async {
    return await _appLaunchDataSource.check;
  }
}
