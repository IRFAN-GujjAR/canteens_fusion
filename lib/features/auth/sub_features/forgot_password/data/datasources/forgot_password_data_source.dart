import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/data/models/forgot_password_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgotPasswordDataSource {
  Future<ForgotPasswordModel> sendPasswordResetEmail(String email);
}

class ForgotPasswordDataSourceImpl implements ForgotPasswordDataSource {
  final FirebaseAuth _auth;

  ForgotPasswordDataSourceImpl(this._auth);

  @override
  Future<ForgotPasswordModel> sendPasswordResetEmail(String email) async {
    await FirebaseAuthUtils.sendPasswordResetEmail(_auth, email: email);
    return ForgotPasswordModel(email: email);
  }
}
