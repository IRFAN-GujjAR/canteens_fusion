import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyEmailDataSource {
  Future<void> get sendVerifyEmail;
}

class VerifyEmailDataSourceImpl implements VerifyEmailDataSource {
  final FirebaseAuth _firebaseAuth;

  VerifyEmailDataSourceImpl(this._firebaseAuth);

  @override
  Future<void> get sendVerifyEmail async =>
      await FirebaseAuthUtils.sendEmailVerification(_firebaseAuth.currentUser!);
}
