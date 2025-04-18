import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';

class UserUpdateDisplayNameParams extends UserUpdateParams {
  final String name;
  const UserUpdateDisplayNameParams(
      {super.updateFirebaseAuth,
      super.updateFireStore,
      required this.name,
      required super.userType});

  Map<String, String> toJson() {
    return {FirebaseConstants.displayName: name};
  }
}
