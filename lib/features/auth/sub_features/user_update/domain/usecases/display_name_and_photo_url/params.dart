import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UserUpdateDisplayNameAndPhotoParams extends UserUpdateParams {
  final String name;
  final XFile? profileImage;

  const UserUpdateDisplayNameAndPhotoParams(
      {required this.name, required this.profileImage, required super.userType})
      : super(updateFirebaseAuth: true, updateFireStore: true);

  Map<String, String> toJson(String profileImageUrl) => {
        FirebaseConstants.displayName: name,
        if (profileImageUrl.isNotEmpty)
          FirebaseConstants.userPhotoUrl: profileImageUrl
      };
}
