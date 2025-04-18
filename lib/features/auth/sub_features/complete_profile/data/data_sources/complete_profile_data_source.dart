import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/sub_features/complete_profile/domain/use_cases/params/complete_profile_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/data/datasources/user_update_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CompleteProfileDataSource {
  Future<UserModel> completeProfile(CompleteProfileParams params);
}

class CompleteProfileDataSourceImpl implements CompleteProfileDataSource {
  final UserUpdateDataSource _userUpdateDataSource;
  final FirebaseAuth _firebaseAuth;

  CompleteProfileDataSourceImpl(this._userUpdateDataSource, this._firebaseAuth);

  @override
  Future<UserModel> completeProfile(CompleteProfileParams params) async {
    await _userUpdateDataSource.updateDisplayNameAndPhoto(
        UserUpdateDisplayNameAndPhotoParams(
            name: params.name,
            profileImage: params.profileImage,
            userType: params.userType));
    final currentUser = await FirebaseAuthUtils.reloadUser(_firebaseAuth);
    return UserModel.fromFirebaseUser(
        firebaseUser: currentUser, userType: params.userType);
  }
}
