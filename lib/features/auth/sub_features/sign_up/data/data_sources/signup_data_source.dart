import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupDataSource {
  Future<UserModel> registerUser(SignupRegisterUserParams params);
}

class SignupDataSourceImpl implements SignupDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  SignupDataSourceImpl(this._firebaseAuth, this._fireStore);

  @override
  Future<UserModel> registerUser(SignupRegisterUserParams params) async {
    final userCredential =
        await FirebaseAuthUtils.createUserWithEmailAndPassword(_firebaseAuth,
            email: params.email, password: params.password);
    final user = userCredential.user;
    final userModel = UserModel.fromFirebaseUser(
        firebaseUser: user!, userType: params.userType);
    await _addUser(userModel: userModel);
    return userModel;
  }

  Future<void> _addUser({required UserModel userModel}) async {
    try {
      final docRef = CloudFireStoreUtils.getUserReference(
        _fireStore,
        userType: userModel.userType,
        uid: userModel.uid,
      );
      await CloudFireStoreUtils.setDocument(docRef, data: userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
