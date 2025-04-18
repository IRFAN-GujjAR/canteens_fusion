import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';

class UserUpdateEmailVerifiedParams extends UserUpdateParams {
  const UserUpdateEmailVerifiedParams(
      {super.updateFirebaseAuth,
      super.updateFireStore,
      required super.userType});

  Map<String, bool> toJson() {
    return {FirebaseConstants.isEmailVerified: true};
  }
}
