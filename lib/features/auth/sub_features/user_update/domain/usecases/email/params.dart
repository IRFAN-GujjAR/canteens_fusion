import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';

class UserUpdateEmailParams extends UserUpdateParams {
  final String email;

  const UserUpdateEmailParams(
      {super.updateFirebaseAuth,
      super.updateFireStore,
      required this.email,
      required super.userType});

  Map<String, String> toJson() {
    return {FirebaseConstants.email: email};
  }
}
