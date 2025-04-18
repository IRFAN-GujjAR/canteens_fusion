import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthManageRemoteDataSource {
  Future<UserModel> reloadUser(UserType userType);
}

class AuthManageRemoteDataSourceImpl extends AuthManageRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthManageRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> reloadUser(UserType userType) async {
    final currentUser = await FirebaseAuthUtils.reloadUser(_firebaseAuth);
    return UserModel.fromFirebaseUser(
        firebaseUser: currentUser, userType: userType);
  }
}
