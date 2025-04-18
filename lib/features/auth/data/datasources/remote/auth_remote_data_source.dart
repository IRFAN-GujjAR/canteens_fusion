import 'dart:math';

import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';
import 'package:canteens_fusion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(LoginParams loginParams);
}

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._fireStore);

  @override
  Future<UserModel> signIn(LoginParams loginParams) async {
    try {
      final userCredential = await FirebaseAuthUtils.signInWithEmailAndPassword(
          _firebaseAuth,
          email: loginParams.email,
          password: loginParams.password);

      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final userModel = UserModel.fromFirebaseUser(
            firebaseUser: firebaseUser, userType: loginParams.userType);
        final user = await _checkUserAlreadyAdded(userModel: userModel);
        if (user != null) {
          return await _handleUserAlreadyAdded(
              userModel.update(userType: user.userType), loginParams.userType);
        } else {
          final user1 = await _checkUserAlreadyAdded(
              userModel: UserModel.fromFirebaseUser(
                  firebaseUser: firebaseUser,
                  userType: loginParams.userType.reverseUserType));
          if (user1 != null) {
            return await _handleUserAlreadyAdded(
                userModel.update(userType: user1.userType),
                loginParams.userType);
          } else {
            try {
              await _addUser(userModel: userModel);
            } catch (error) {
              await _firebaseAuth.signOut();
              rethrow;
            }
            return userModel;
          }
        }
      } else {
        throw AuthLoginErrorState(errorMsg: 'Unexpected error');
      }
    } catch (e) {
      await _firebaseAuth.signOut();
      rethrow;
    }
  }

  Future<UserModel?> _checkUserAlreadyAdded(
      {required UserModel userModel}) async {
    final docRef = CloudFireStoreUtils.getUserReference(_fireStore,
        userType: userModel.userType, uid: userModel.uid);
    try {
      final docSnapShot = await CloudFireStoreUtils.getDocument(docRef);
      if (docSnapShot.exists) {
        final json = docSnapShot.data() as Map<String, dynamic>;
        final fireStoreUser = UserModel.fromJson(json);
        if (userModel == fireStoreUser) {
          return fireStoreUser;
        } else {
          await CloudFireStoreUtils.updateDocument(docRef,
              data: userModel.toJson());
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel> _handleUserAlreadyAdded(
      UserModel user, UserType userType) async {
    if (user.userType != userType) {
      await FirebaseAuthUtils.signOut(_firebaseAuth);
      final userTypeName = userTypes[user.userType];
      throw AuthWrongUserTypeErrorState(
          errorMsg:
              "You're already regisered as a $userTypeName. Please Login as $userTypeName");
    } else {
      return user;
    }
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
