import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/shared_pref/shared_pref_utils.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  UserModel getCurrentUser(UserType userType);
  Future<void> changeUserType(UserType userType);
}

final class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;
  final SharedPrefUtils _prefUtils;
  AuthLocalDataSourceImpl(
      {required FirebaseAuth firebaseAuth,
      required SharedPreferences prefs,
      required SharedPrefUtils prefsUtils})
      : _firebaseAuth = firebaseAuth,
        _prefs = prefs,
        _prefUtils = prefsUtils;

  @override
  UserModel getCurrentUser(UserType userType) {
    return UserModel.fromFirebaseUser(
        firebaseUser: _firebaseAuth.currentUser!, userType: userType);
  }

  @override
  Future<void> changeUserType(UserType userType) async {
    await _prefUtils.setUserType(pref: _prefs, userType: userType);
  }
}
