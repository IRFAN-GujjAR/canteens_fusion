import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UserUpdatePhotoParams extends UserUpdateParams {
  final XFile profileImage;

  const UserUpdatePhotoParams(
      {required this.profileImage, required super.userType})
      : super(updateFireStore: true, updateFirebaseAuth: true);

  Map<String, String> toJson(String profileImageUrl) =>
      {FirebaseConstants.userPhotoUrl: profileImageUrl};
}
