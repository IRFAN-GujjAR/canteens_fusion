import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/app_launch/domain/usecases/app_launch_use_case.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_change_user_type_usecase.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_current_user_usecase.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_reload_user_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final class UserSessionProvider extends ChangeNotifier {
  final AuthCurrentUserUseCase _currentUserUseCase;
  final AuthReloadUserUseCase _reloadUserUseCase;
  final AuthChangeUserTypeUseCase _changeUserTypeUseCase;

  UserSessionProvider(this._currentUserUseCase, this._reloadUserUseCase,
      this._changeUserTypeUseCase);

  UserType _userType = UserType.none;
  UserType get userType => _userType;
  String get userTypeName => userTypes[userType]!;

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;
  set setCurrentUser(UserEntity user) {
    _currentUser = user;
  }

  Future<void> checkShowUserTypeSelectionPage(
      AppLaunchUseCase appLaunchUseCase) async {
    final appLaunchEntity = await appLaunchUseCase.call;
    if (appLaunchEntity.user != null) {
      _currentUser = appLaunchEntity.user;
    }
    _userType = appLaunchEntity.userType;
  }

  Future<void> setUserType({required UserType userType}) async {
    await _changeUserTypeUseCase.call(userType);
    _userType = userType;
  }

  bool get isUserLoggedIn => locator.get<FirebaseAuth>().currentUser != null;

  bool get isUserOwner => userType == UserType.owner;

  bool get isUserTypeSelected => userType != UserType.none;

  UserEntity get getCurrentUser {
    return _currentUserUseCase.call(userType);
  }

  Future<void> get reloadUser async {
    try {
      setCurrentUser = await _reloadUserUseCase.call(userType);
    } catch (e) {
      printDebugMesg(
          dartFileName: 'UserSessionProvider - UserReload', msg: e.toString());
    }
  }

  void signOut(BuildContext context) {
    _signOut.then((value) {
      NavigationUtils.navigate(
          context: context,
          commonNavigationPageType: CommonNavigationPageType.login,
          removePreviousPages: true);
    });
  }

  Future<void> get _signOut async {
    await locator.get<FirebaseAuth>().signOut();
    _currentUser = null;
    notifyListeners();
  }
}
