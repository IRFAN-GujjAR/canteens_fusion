import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/params.dart';

abstract class UserUpdateRepo {
  Future<void> updateDisplayName(UserUpdateDisplayNameParams params);
  Future<void> updateEmail(UserUpdateEmailParams params);
  Future<void> updateEmailVerified(UserUpdateEmailVerifiedParams params);
  Future<void> updatePhoneNumber(UserUpdatePhoneNumberParams params);
  Future<void> updatePhotoUrl(UserUpdatePhotoParams params);
  Future<void> updateDisplayNameAndPhotoUrl(
      UserUpdateDisplayNameAndPhotoParams params);
}
