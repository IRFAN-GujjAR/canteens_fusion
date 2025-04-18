import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/shared_pref/shared_pref_utils.dart';
import 'package:canteens_fusion/features/app_launch/data/models/app_launch_model.dart';
import 'package:canteens_fusion/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLaunchDataSource {
  Future<AppLaunchModel> get check;
}

class AppLaunchDataSourceImpl extends AppLaunchDataSource {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;
  final SharedPrefUtils _prefsUtil;
  final AuthLocalDataSource _authLocalDataSource;

  AppLaunchDataSourceImpl(
      {required AuthLocalDataSource authLocalDataSource,
      required FirebaseAuth firebaseAuth,
      required SharedPreferences prefs,
      required SharedPrefUtils prefsUtil})
      : _authLocalDataSource = authLocalDataSource,
        _firebaseAuth = firebaseAuth,
        _prefs = prefs,
        _prefsUtil = prefsUtil;

  @override
  Future<AppLaunchModel> get check async {
    final isAppStartedForFirstTime =
        _prefsUtil.isAppStartedForFirstTime(pref: _prefs);
    UserType userType = UserType.none;
    bool showUserTypeSelectionPage = false;
    UserModel? user;
    if (isAppStartedForFirstTime) {
      await _prefsUtil.setAppStartedFirstTime(pref: _prefs);
      showUserTypeSelectionPage = true;
    } else {
      final userTypeName = _prefsUtil.getUserType(pref: _prefs);
      userType = userTypesStoE[_prefsUtil.getUserType(pref: _prefs)]!;
      if (userTypeName == UserTypeConstants.none) {
        showUserTypeSelectionPage = true;
      } else {
        if (_isUserLoggedIn) {
          user = _authLocalDataSource.getCurrentUser(userType);
        }
      }
    }
    return AppLaunchModel(
        showUserTypeSelectionPage: showUserTypeSelectionPage,
        userType: userType,
        user: user);
  }

  bool get _isUserLoggedIn => _firebaseAuth.currentUser != null;
}
