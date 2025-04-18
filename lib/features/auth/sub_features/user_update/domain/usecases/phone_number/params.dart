import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/user_update_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUpdatePhoneNumberParams extends UserUpdateParams {
  final String phoneNumber;
  final PhoneAuthCredential? phoneAuthCredential;

  const UserUpdatePhoneNumberParams(
      {super.updateFirebaseAuth = false,
      super.updateFireStore,
      required this.phoneNumber,
      this.phoneAuthCredential,
      required super.userType});

  Map<String, String> toJson() {
    return {FirebaseConstants.phoneNumber: phoneNumber};
  }
}
