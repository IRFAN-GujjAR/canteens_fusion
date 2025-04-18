import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefUtils {
  final String _appStartedFirstTime = 'app_started_first_time';
  final String _userType = 'user_type';

  bool isAppStartedForFirstTime({required SharedPreferences pref}) {
    final firstTimeStart = pref.getBool(_appStartedFirstTime);
    return firstTimeStart == null || firstTimeStart;
  }

  Future<void> setAppStartedFirstTime({required SharedPreferences pref}) async {
    await pref.setBool(_appStartedFirstTime, false);
  }

  String getUserType({required SharedPreferences pref}) {
    final userType = pref.getString(_userType);
    if (userType == null) {
      return userTypes[UserType.none]!;
    }
    return userType;
  }

  Future<void> setUserType(
      {required SharedPreferences pref, required UserType userType}) async {
    await pref.setString(_userType, userTypes[userType]!);
  }
}
