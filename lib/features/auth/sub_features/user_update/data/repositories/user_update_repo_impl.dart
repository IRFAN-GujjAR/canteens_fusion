import 'package:canteens_fusion/features/auth/sub_features/user_update/data/datasources/user_update_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/params.dart';

class UserUpdateRepoImpl extends UserUpdateRepo {
  final UserUpdateDataSource _userUpdateDataSource;

  UserUpdateRepoImpl(this._userUpdateDataSource);

  @override
  Future<void> updateDisplayName(UserUpdateDisplayNameParams params) async {
    await _userUpdateDataSource.updateDisplayName(params);
  }

  @override
  Future<void> updateDisplayNameAndPhotoUrl(
      UserUpdateDisplayNameAndPhotoParams params) async {
    await _userUpdateDataSource.updateDisplayNameAndPhoto(params);
  }

  @override
  Future<void> updateEmail(UserUpdateEmailParams params) async {
    await _userUpdateDataSource.updateEmail(params);
  }

  @override
  Future<void> updateEmailVerified(UserUpdateEmailVerifiedParams params) async {
    await _userUpdateDataSource.updateEmailVerified(params);
  }

  @override
  Future<void> updatePhoneNumber(UserUpdatePhoneNumberParams params) async {
    await _userUpdateDataSource.updatePhoneNumber(params);
  }

  @override
  Future<void> updatePhotoUrl(UserUpdatePhotoParams params) async {
    await _userUpdateDataSource.updatePhoto(params);
  }
}
